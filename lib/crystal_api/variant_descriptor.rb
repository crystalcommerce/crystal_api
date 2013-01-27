module CrystalApi
  class VariantDescriptor
    include Attributes

    root_element :variant_descriptor

    string_attribute :name
    string_attribute :value
  end
end
