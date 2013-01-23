require 'set'
require 'active_support'

module CrystalApi
  module Attributes
    class NoRootElementDefined < StandardError
    end

    module ClassMethods
      attr_reader :attributes

      def money_attribute(attribute_name)
        attr_reader attribute_name
        @attributes[attribute_name.to_s] = :money
      end

      def integer_attribute(attribute_name)
        attr_reader attribute_name
        @attributes[attribute_name.to_s] = :integer
      end

      def boolean_attribute(attribute_name)
        attr_reader attribute_name
        @attributes[attribute_name.to_s] = :boolean
        define_method("#{attribute_name.to_s.match(/^is_(.*)$/)[1]}?") do
          send(attribute_name)
        end
      end

      def string_attribute(attribute_name)
        attr_reader attribute_name
        @attributes[attribute_name.to_s] = :string
      end

      def object_attribute(attribute_name)
        attr_reader attribute_name
        @attributes[attribute_name.to_s] = :object
      end

      def array_attribute(attribute_name, type)
        attr_reader attribute_name
        @attributes[attribute_name.to_s] = [:array, type]
      end

      def root_element(elem)
        @root_element = elem.to_s
      end

      def get_root_element
        klass = self
        @root_element || raise(NoRootElementDefined.new("No root element was defined for #{klass.name}"))
      end

      def from_json(json_hash)
        attrs = attributes.keys.inject({}) do |acc, attr|
          val = json_hash.fetch(get_root_element, {})[attr]
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

    private

    def parse_arg(arg, value)
      type, type2 = self.class.attributes[arg.to_s]
      if type
        if type2 && value
          value.map do |val|
            send("parse_#{type2}", val)
          end
        else
          send("parse_#{type}", value)
        end
      end
    end

    def parse_money(value)
      if value.is_a?(Hash)
        Money.new(value['money']['cents'],
                  value['money'].fetch('currency', 'USD'))
      else
        Money.parse(value)
      end
    end

    def parse_integer(value)
      value.to_i
    end

    def parse_boolean(value)
      value == 'true' || value == '1' || value == true
    end

    def parse_string(value)
      value.to_s
    end

    def parse_object(value)
      return if value.nil?

      klass = find_klass(value.keys.first)
      klass.from_json(value) if klass
    end

    def find_klass(word)
      camel_cased_word = ActiveSupport::Inflector.camelize(word)

      CrystalApi.const_defined?("#{camel_cased_word}") &&
        CrystalApi.const_get(camel_cased_word)
    end
  end
end
