require 'spec_helper'

describe CrystalApi::WebhookEnvelope do

  subject { CrystalApi::WebhookEnvelope.new }

  describe "#from_json" do
    let(:json_hash) {{
      "webhook_envelope" => {
        "topic"       => "product/update",
        "store_name"  => "examplestore",
        "resource_id" => 385,
        "payload"     => {'variant' => {'id' => 1}}}
    }}

    subject { CrystalApi::WebhookEnvelope.from_json(json_hash) }

    its(:topic)       { should == "product/update" }
    its(:store_name)  { should == "examplestore"}
    its(:resource_id) { should == 385 }
    its(:payload)     { should be_a(CrystalApi::Variant) }
  end
end
