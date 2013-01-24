module CrystalApi
	class MarketPrices
		include Attributes

		root_element :market_prices

		object_attribute :high_market_price
		object_attribute :low_market_price
		object_attribute :market_price
	end
end
