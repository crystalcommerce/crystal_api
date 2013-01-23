module CrystalApi
	class WebhookEnvelope
		include Attributes

		root_element :webhook_envelope

		string_attribute :topic
		string_attribute :store_name
		integer_attribute :resource_id
		object_attribute :payload
	end
end
