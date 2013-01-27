module CrystalApi
  class ProductDescriptor
    include Attributes

    root_element :product_descriptor

    string_attribute :name
    string_attribute :value
  end
end
