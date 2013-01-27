module CrystalApi
  class Store
    include Attributes

    root_element :store

    string_attribute :name
    string_attribute :database_name
  end
end
