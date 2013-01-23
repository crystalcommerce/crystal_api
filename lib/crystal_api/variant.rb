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

    def self.from_json(raw)
      new(id:                     raw['variant']['id'],
          product_id:             raw['variant']['product_id'],
          qty:                    raw['variant']['qty'],
          wtb_qty:                raw['variant']['wtb_qty'],
          catalog_id:             raw['variant']['catalog_id'],
          is_default:             raw['variant']['is_default'],
          is_infinite_qty:        raw['variant']['is_infinite_qty'],
          sell_price:             raw['variant']['sell_price'],
          buy_price:              raw['variant']['buy_price'],
          store_credit_buy_price: raw['variant']['store_credit_buy_price'])
    end
  end
end
