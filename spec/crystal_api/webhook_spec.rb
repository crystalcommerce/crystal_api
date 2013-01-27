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

  describe "#as_json" do
    subject { CrystalApi::Webhook.new(address: "https://example.com/cb",
                                      resource_id: 123,
                                      topic: "pages/create",
                                      id: 1) }

    its(:as_json) { should == {
      "webhook" => {
        "address"     => "https://example.com/cb",
        "resource_id" => 123,
        "topic"       => "pages/create",
        "id"          => 1
      }
    }}

    describe "except key" do
      it "ignores the key expected" do
        subject.as_json(:except => [:id]).should == {
          "webhook" => {
            "address"     => "https://example.com/cb",
            "resource_id" => 123,
            "topic"       => "pages/create"
          }
        }
      end
    end
  end
end
