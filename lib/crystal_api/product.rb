module CrystalApi
  class Product
    include Attributes

    root_element :product

    integer_attribute :id
    integer_attribute :catalog_id

    string_attribute :name
    string_attribute :seoname
    string_attribute :description

    decimal_attribute :weight

    integer_attribute :qty
    integer_attribute :wtb_qty
    integer_attribute :max_qty

    boolean_attribute :is_buying
    boolean_attribute :is_selling
    boolean_attribute :is_domestic_only
    boolean_attribute :is_preorder

    object_attribute :msrp
    object_attribute :base_sell_price
    object_attribute :base_buy_price
    object_attribute :min_sell_price
    object_attribute :max_sell_price
    object_attribute :min_buy_price
    object_attribute :max_buy_price

    datetime_attribute :updated_at
    date_attribute :available_on

    object_attribute :default_variant

    array_attribute :related_tag_list, :string
    array_attribute :tag_list, :string

    array_attribute :variant_dimensions, :string

    array_attribute :photos, :object
    array_attribute :descriptors, :object

    hash_attribute :catalog_links, :url
    hash_attribute :buylist_links, :url

    embedded_attribute :category

    embedded_attribute :variants, :array

    embedded_attribute :market_prices
  end
end
