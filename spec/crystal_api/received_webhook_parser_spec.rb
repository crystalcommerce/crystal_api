require 'spec_helper'

describe CrystalApi::ReceivedWebhookParser do
	let(:raw_post) {{'foo' => 'bar'}.to_json}
	let(:webhook_envelope) { mock("WebhookEnvelope") }

	before(:each) do
		CrystalApi::WebhookEnvelope.stub(:new).and_return(webhook_envelope)
	end

	subject { CrystalApi::ReceivedWebhookParser.new(raw_post) }

	describe "#webhook" do
		it "instantiates a new webhook envelope with the parsed raw post" do
			CrystalApi::WebhookEnvelope.should_receive(:from_json).with({'foo' => 'bar'})
			subject.webhook
		end

		it "returns the instantiated webhook envelope" do
			subject.webhook.should == webhook_envelope
		end
	end
end
