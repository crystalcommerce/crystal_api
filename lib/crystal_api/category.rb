module CrystalApi
	class Category
		include Attributes

		root_element :category

		string_attribute :name
	end
end
