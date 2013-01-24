require 'spec_helper'

describe CrystalApi::Photo do
	describe ".from_json" do
		let(:json_hash) do
			{
        "photo" => {
          "urls" => {
            "large" => {
              "href" => "http://client-cdn.crystalcommerce.com/photo/arux/file/75b074b9647299b25110acced18b3943/large/LOTUS_COBRA.png"
            },
            "huge" => {
              "href" => "http://client-cdn.crystalcommerce.com/photo/arux/file/75b074b9647299b25110acced18b3943/huge/LOTUS_COBRA.png"
            },
            "medium" => {
              "href" => "http://client-cdn.crystalcommerce.com/photo/arux/file/75b074b9647299b25110acced18b3943/medium/LOTUS_COBRA.png"
            },
            "thumb" => {
              "href" => "http://client-cdn.crystalcommerce.com/photo/arux/file/75b074b9647299b25110acced18b3943/thumb/LOTUS_COBRA.png"
            },
            "original" => {
              "href" => "http://client-cdn.crystalcommerce.com/photo/arux/file/75b074b9647299b25110acced18b3943/LOTUS_COBRA.PNG"
            }
          },
          "is_default" => true
        }
			}
		end

		subject { CrystalApi::Photo.from_json(json_hash) }

		its(:is_default) { should == true }
		its(:urls) { should == {
			"large"    => CrystalApi::Url.new(href: "http://client-cdn.crystalcommerce.com/photo/arux/file/75b074b9647299b25110acced18b3943/large/LOTUS_COBRA.png"),
			"huge"     => CrystalApi::Url.new(href: "http://client-cdn.crystalcommerce.com/photo/arux/file/75b074b9647299b25110acced18b3943/huge/LOTUS_COBRA.png"),
			"medium"   => CrystalApi::Url.new(href: "http://client-cdn.crystalcommerce.com/photo/arux/file/75b074b9647299b25110acced18b3943/medium/LOTUS_COBRA.png"),
			"thumb"    => CrystalApi::Url.new(href: "http://client-cdn.crystalcommerce.com/photo/arux/file/75b074b9647299b25110acced18b3943/thumb/LOTUS_COBRA.png"),
			"original" => CrystalApi::Url.new(href: "http://client-cdn.crystalcommerce.com/photo/arux/file/75b074b9647299b25110acced18b3943/LOTUS_COBRA.PNG")
		}}
	end
end
