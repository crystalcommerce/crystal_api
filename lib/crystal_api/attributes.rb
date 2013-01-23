require 'set'

module CrystalApi
  module Attributes
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
    end

    def initialize(args = {})
      args.each do |arg, value|
        instance_variable_set("@#{arg}", parse_arg(arg, value))
      end
      self.freeze
    end

    def self.included(receiver)
      receiver.extend(ClassMethods)
      receiver.class_eval do
        @attributes = {}
      end
    end

    private

    def parse_arg(arg, value)
      send("parse_#{self.class.attributes[arg.to_s]}", value)
    end

    def parse_money(value)
      Money.parse(value)
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
  end
end
