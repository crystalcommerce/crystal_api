module CrystalApi
	class Photo
		include Attributes

		root_element :photo

		boolean_attribute :is_default
		hash_attribute :urls, :url
	end
end
