module CrystalApi
  class Report
    include Attributes

    root_element :report

    integer_attribute :id
    string_attribute :status
    string_attribute :report_type

    datetime_attribute :created_at
    datetime_attribute :expires_at
    datetime_attribute :updated_at

    hash_attribute :_links, :url
  end
end
