require 'spec_helper'

describe CrystalApi::Webhook do
  describe ".from_json" do
    let(:json_hash) {{
      "webhook" => {
        "address"     => "https://example.com/cb",
        "resource_id" => 123,
        "topic"       => "pages/create",
        "id"          => 11,
        "only_catalog" => true
      }
    }}

    subject { CrystalApi::Webhook.from_json(json_hash) }

    its(:address)     { should == "https://example.com/cb" }
    its(:resource_id) { should == 123 }
    its(:topic)       { should == "pages/create" }
    its(:id)          { should == 11 }
    its(:only_catalog) { should == true }
  end

  describe "#as_json" do
    subject { CrystalApi::Webhook.new(address: "https://example.com/cb",
                                      resource_id: 123,
                                      topic: "pages/create",
                                      id: 1,
                                      only_catalog: true) }

    its(:as_json) { should == {
      "webhook" => {
        "address"     => "https://example.com/cb",
        "resource_id" => 123,
        "topic"       => "pages/create",
        "id"          => 1,
        "only_catalog" => true
      }
    }}

    describe "except key" do
      it "ignores the key expected" do
        subject.as_json(:except => [:id]).should == {
          "webhook" => {
            "address"     => "https://example.com/cb",
            "resource_id" => 123,
            "topic"       => "pages/create",
            "only_catalog" => true
          }
        }
      end
    end
  end
end
