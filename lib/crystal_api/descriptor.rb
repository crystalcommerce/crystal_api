module CrystalApi
  class Descriptor
    include Attributes

    root_element :descriptor

    boolean_attribute :is_enable_filter
    string_attribute :name
    array_attribute :options, :string
  end
end
