module CrystalApi
  class Product
    include Attributes

    root_element :product

    integer_attribute :id
		string_attribute :name
		string_attribute :seoname
		string_attribute :description

    #money_attribute :min_sell_price
    #money_attribute :buy_price
    #money_attribute :store_credit_buy_price

    #integer_attribute :product_id
    #integer_attribute :qty
    #integer_attribute :wtb_qty

    #string_attribute :catalog_id

    #boolean_attribute :is_default
    #boolean_attribute :is_infinite_qty

    #array_attribute :descriptors, :object
  end
end
