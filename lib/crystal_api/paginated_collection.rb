module CrystalApi
  class PaginatedCollection
    include Attributes

    root_element :paginated_collection

    integer_attribute :total_entries
    integer_attribute :total_pages
    integer_attribute :previous_page
    integer_attribute :next_page
    array_attribute :entries
  end
end
