require 'spec_helper'

describe CrystalApi::Category do
	describe ".from_json" do
		let(:json_hash) {{
			"category" => {
				"id" => 321,
				"catalog_id" => 1,
				"name" => "Return to Ravnica Block",
				"seoname" => "return_to_ravnica_block",
				"is_root" => false,
				"is_visible_for_buying" => false,
				"is_visible_for_selling" => true,
				"description" => "describe this!",
				"is_leaf" => false,
				"browse_layout" => "Hybrid4x1",
				"photos" => [],
				"buylist_links" => {
					"en" => {
						"href" => "http://www.example.com/buylist/return_to_ravnica_block/321"
					}
				},
				"catalog_links" => {
					"en" => {
						"href" => "http://www.example.com/catalog/return_to_ravnica_block/321"
					}
				},
				"_links" => {
					"self" => { "href" => "/v1/categories/321" },
					"products" => { "href" => "/v1/categories/321/products" },
					"children" => { "href" => "/v1/categories/321/children" },
					"tree" => { "href" => "/v1/categories/321/tree" },
					"parent_category" => { "href" => "/v1/categories/8" }
				},
				"descriptors" => [
					{
						"descriptor" => {
							"is_enable_filter" => true,
							"name" => "Card Type",
							"options" => []
						}
					},
					{
						"descriptor" => {
							"is_enable_filter" => true,
							"name" => "Color",
							"options" => [
								"Artifact",
								"Black",
								"Blue",
								"Green",
								"Land",
								"Multi-Color",
								"Red",
								"White",
								"Colorless"
							]
						}
					}
				],
				"_embedded" => {
					"ancestors" => [
						{ "category" => { "name" => "My Store" } },
						{ "category" => { "name" => "Magic Singles!" } }
					]
				}
			}
		}}

		subject { CrystalApi::Category.from_json(json_hash) }

		its(:id) { should == 321 }
		its(:catalog_id) { should == 1 }
		its(:name) { should == "Return to Ravnica Block" }
		its(:seoname) { should == "return_to_ravnica_block" }

		its(:is_root) { should == false }
		its(:root?) { should == false }

		its(:is_leaf) { should == false }
		its(:leaf?) { should == false }

		its(:is_visible_for_buying) { should == false }
		its(:visible_for_buying?) { should == false }

		its(:is_visible_for_selling) { should == true }
		its(:visible_for_selling?) { should == true }

		its(:description) { should == "describe this!" }
		its(:browse_layout) { should == "Hybrid4x1" }

    its(:catalog_links) { should == {
      "en" => CrystalApi::Url.new(href: "http://www.example.com/catalog/return_to_ravnica_block/321")
    }}

    its(:buylist_links) { should == {
      "en" => CrystalApi::Url.new(href: "http://www.example.com/buylist/return_to_ravnica_block/321")
    }}

		its(:descriptors) { should == [
			CrystalApi::Descriptor.new(is_enable_filter: true, name: "Card Type", options: []),
			CrystalApi::Descriptor.new(is_enable_filter: true, name: "Color", options: [
				"Artifact", "Black", "Blue", "Green", "Land", "Multi-Color", "Red",
				"White", "Colorless"])
		] }

		its(:ancestors) { should == [
			CrystalApi::Category.new(name: "My Store"),
			CrystalApi::Category.new(name: "Magic Singles!")
		]}
	end
end
