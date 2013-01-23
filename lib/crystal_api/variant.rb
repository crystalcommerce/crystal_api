module CrystalApi
  class Variant
    include Attributes

    money_attribute :sell_price
    money_attribute :buy_price
    money_attribute :store_credit_buy_price

    integer_attribute :id
    integer_attribute :product_id
    integer_attribute :qty
    integer_attribute :wtb_qty

    string_attribute :catalog_id

    boolean_attribute :is_default
    boolean_attribute :is_infinite_qty
  end
end
