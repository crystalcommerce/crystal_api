module CrystalApi
	class Webhook
		include Attributes

		root_element :webhook

		integer_attribute :id
		integer_attribute :resource_id

		string_attribute :address
		string_attribute :topic
	end
end
