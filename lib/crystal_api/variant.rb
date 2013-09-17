module CrystalApi
  class Variant
    include Attributes

    root_element :variant

    object_attribute :sell_price
    object_attribute :buy_price
    object_attribute :store_credit_buy_price

    integer_attribute :id
    integer_attribute :product_id
    integer_attribute :product_catalog_id
    integer_attribute :qty
    integer_attribute :actual_qty
    integer_attribute :inventory_qty
    integer_attribute :wtb_qty

    string_attribute :catalog_id
    string_attribute :product_name
    string_attribute :category_name

    boolean_attribute :is_default
    boolean_attribute :is_infinite_qty

    array_attribute :descriptors, :object
  end
end
