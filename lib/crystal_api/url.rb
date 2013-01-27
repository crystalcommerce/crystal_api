module CrystalApi
  class Url
    include Attributes

    root_element :url

    string_attribute :href
  end
end
