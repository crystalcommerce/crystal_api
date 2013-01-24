module CrystalApi
	class Category
		include Attributes

		root_element :category

		integer_attribute :id
		integer_attribute :catalog_id

		string_attribute :name
		string_attribute :seoname

		boolean_attribute :is_root
		boolean_attribute :is_leaf
		boolean_attribute :is_visible_for_selling
		boolean_attribute :is_visible_for_buying

		string_attribute :description
		string_attribute :browse_layout

    hash_attribute :catalog_links, :url
    hash_attribute :buylist_links, :url

		array_attribute :descriptors

		embedded_attribute :ancestors, :array
	end
end
