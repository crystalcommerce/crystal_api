require 'set'
require 'bigdecimal'

module CrystalApi
  module Attributes
    class NoRootElementDefined < StandardError
    end

    module ClassMethods
      attr_reader :attributes

      [:integer, :decimal, :string, :object, :datetime, :date, :url].each do |type|
        define_method("#{type}_attribute") do |attribute_name|
          attr_reader attribute_name
          @attributes[attribute_name.to_s] = type
        end
      end

      def boolean_attribute(attribute_name)
        attr_reader attribute_name
        @attributes[attribute_name.to_s] = :boolean

        if matches = attribute_name.to_s.match(/^is_(.*)$/)
          define_method("#{matches[1]}?") do
            send(attribute_name)
          end
        else
          alias_method "#{attribute_name}?", attribute_name
        end
      end

      def embedded_attribute(attribute_name, type = :object)
        attr_reader attribute_name
        @attributes[attribute_name.to_s] = [:embedded, type]
      end

      def array_attribute(attribute_name, type = :object)
        attr_reader attribute_name
        @attributes[attribute_name.to_s] = [:array, type]
      end

      def hash_attribute(attribute_name, type)
        attr_reader attribute_name
        @attributes[attribute_name.to_s] = [:hash, type]
      end

      def attribute(attribute_name)
        attr_reader attribute_name
        @attributes[attribute_name.to_s] = :unknown
      end

      def root_element(elem)
        @root_element = elem.to_s
      end

      def get_root_element
        klass = self
        @root_element || raise(NoRootElementDefined.new("No root element was defined for #{klass.name}"))
      end

      def from_json(json_hash)
        json_attributes = json_hash.fetch(get_root_element, json_hash)
        embedded = json_attributes.delete("_embedded") || {}
        attrs = attributes.inject({}) do |acc, (attr, type)|
          if Array(type).first == :embedded
            val = embedded[attr]
          else
            val = json_attributes[attr]
          end
          acc[attr] = val unless val.nil?
          acc
        end
        new(attrs)
      end
    end

    def initialize(args = {})
      unexpected_keys = []

      args.each do |arg, value|
        if self.class.attributes.has_key?(arg.to_s)
          instance_variable_set("@#{arg}", parse_arg(arg, value))
        else
          unexpected_keys << arg
        end
      end

      if !unexpected_keys.empty?
        raise ArgumentError.new("Unexpected hash keys: #{unexpected_keys}")
      end

      self.freeze
    end

    def self.included(receiver)
      receiver.extend(ClassMethods)
      receiver.class_eval do
        @attributes = {}
      end
    end

    def ==(other)
      self.eql?(other)
    end

    def eql?(other)
      return false if other.class != self.class
      self.class.attributes.keys.all? do |field|
        self.send(field) == other.send(field)
      end
    end

    def hash
      result = 0
      self.class.attributes.keys.each do |field|
        result += self.send(field).hash
      end
      return result + self.class.hash
    end

    def as_json(options = {})
      {
        root_key => self.class.attributes.inject({}) { |acc, (key, _)|
          unless options.fetch(:except, []).include?(key.to_sym)
            value = send(key)
            acc[key.to_s] = value.respond_to?(:as_json) ? value.as_json : value
          end
          acc
        }
      }
    end

    private

    def root_key
      self.class.get_root_element.to_s
    end

    def parse_arg(arg, value)
      type, type2 = self.class.attributes[arg.to_s]
      if type
        if type2 && value
          send("parse_#{type}", value, type2)
        else
          send("parse_#{type}", value)
        end
      end
    end

    def parse_integer(value)
      value.to_i
    end

    def parse_decimal(value)
      BigDecimal.new(value.to_s) unless value.nil?
    end

    def parse_boolean(value)
      value == 'true' || value == '1' || value == true
    end

    def parse_string(value)
      value.to_s
    end

    def parse_datetime(value)
      DateTime.parse(value) if value
    end

    def parse_date(value)
      Date.parse(value) if value
    end

    def parse_url(value)
      Url.new(value)
    end

    def parse_array(value, type = :object)
      value.map do |val|
        send("parse_#{type}", val)
      end
    end

    def parse_hash(value, type = :object)
      value.inject({}) do |acc, (key, val)|
        acc[key] = send("parse_#{type}", val)
        acc
      end
    end

    def parse_object(value)
      return value unless value.is_a?(Hash)

      klass = CrystalApi.find_klass(value.keys.first)
      klass.from_json(value) if klass
    end

    def parse_embedded(value, type)
      send("parse_#{type}", value)
    end

    def parse_unknown(value)
      if value.is_a?(Hash)
        parse_object(value)
      elsif value.is_a?(Array)
        parse_array(value)
      end
    end
  end
end
