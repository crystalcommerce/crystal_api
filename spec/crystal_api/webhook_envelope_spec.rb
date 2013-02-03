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

    context "multiple items in the payload" do
      let(:json_hash) {{
        "webhook_envelope" => {
          "topic"       => "product/update",
          "store_name"  => "examplestore",
          "resource_id" => 385,
          "payload"     => [
            {'variant' => {'id' => 1}},
            {'variant' => {'id' => 2}}
          ]}
      }}

      subject { CrystalApi::WebhookEnvelope.from_json(json_hash) }

      it "has both variants in the payload" do
        subject.payload.should == [
          CrystalApi::Variant.new(id: 1),
          CrystalApi::Variant.new(id: 2)
        ]
      end
    end
  end
end
