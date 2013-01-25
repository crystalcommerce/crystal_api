$: << (File.join(File.dirname(__FILE__)))

require "crystal_api/version"
require 'money'
require 'active_support'

module CrystalApi
	def self.from_json(object)
		find_klass(object.keys.first).from_json(object)
	end

	def self.find_klass(word)
		camel_cased_word = ActiveSupport::Inflector.camelize(word)

		if CrystalApi.const_defined?("#{camel_cased_word}")
			CrystalApi.const_get(camel_cased_word)
		else
			raise CrystalApi::CannotParseJson.new("No objects to parse #{word}!")
		end
	end
end

require 'crystal_api/money'
require 'crystal_api/attributes'
require 'crystal_api/variant'
require 'crystal_api/webhook_envelope'
require 'crystal_api/store'
require 'crystal_api/received_webhook_parser'
require 'crystal_api/variant_descriptor'
require 'crystal_api/product'
require 'crystal_api/photo'
require 'crystal_api/url'
require 'crystal_api/product_descriptor'
require 'crystal_api/category'
require 'crystal_api/market_prices'
require 'crystal_api/descriptor'
require 'crystal_api/store_prefs'
require 'crystal_api/webhook'
require 'crystal_api/paginated_collection'

require 'crystal_api/store_endpoint'
require 'crystal_api/webhook_registration'
