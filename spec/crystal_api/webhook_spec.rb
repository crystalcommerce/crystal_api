require 'spec_helper'

describe CrystalApi::Webhook do
  describe ".from_json" do
    let(:json_hash) {{
      "webhook" => {
        "address"     => "https://example.com/cb",
        "resource_id" => 123,
        "topic"       => "pages/create",
        "id"          => 11
      }
    }}

    subject { CrystalApi::Webhook.from_json(json_hash) }

    its(:address)     { should == "https://example.com/cb" }
    its(:resource_id) { should == 123 }
    its(:topic)       { should == "pages/create" }
    its(:id)          { should == 11 }
  end
end
