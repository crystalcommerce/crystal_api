require 'spec_helper'

describe CrystalApi::PaginatedCollection do
  describe ".from_json" do
    let(:json_hash) {{
      "paginated_collection" => {
        "total_entries" => 33061,
        "total_pages" => 331,
        "previous_page" => nil,
        "_links" => {
          "self" => {
            "href" => "/v1/products"
          },
          "next_page" => {
            "href" => "/v1/products?page=2"
          }
        },
        "next_page" => 2,
        "entries" => [{"product" => {"name" => "Lotus Cobra"}}]
      }
    }}

    subject { CrystalApi::PaginatedCollection.from_json(json_hash) }

    its(:total_entries) { should == 33061 }
    its(:total_pages) { should == 331 }
    its(:previous_page) { should == nil }
    its(:next_page) { should == 2}
    its(:entries) { should == [CrystalApi::Product.new(name: "Lotus Cobra")] }
  end
end
