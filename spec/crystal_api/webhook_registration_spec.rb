require 'spec_helper'

describe CrystalApi::WebhookRegistration do
  let(:store_endpoint) { mock("Store Endpoint") }

  subject { CrystalApi::WebhookRegistration.new(store_endpoint) }

  describe "#register" do
    let(:parsed_response) { mock("Parsed Response") }
    let(:webhook) { mock("Webhook", :to_json => "{}") }

    before(:each) do
      store_endpoint.stub(:post).and_return(parsed_response)
    end

    it "configures the json to exclude the id in the body" do
      webhook.should_receive(:to_json).with(except: [:id])
      subject.register(webhook)
    end

    it "posts the webhook json to the store endpoint" do
      store_endpoint.should_receive(:post).with('/webhooks', "{}")
      subject.register(webhook)
    end

    it "returns the parsed response" do
      subject.register(webhook).should == parsed_response
    end
  end

  describe "#registered?" do
    let(:parsed_response) { mock("Parsed Response", :parsed => existing_webhooks) }
    let(:existing_webhooks) { [] }
    let(:existing_webhook) { mock("Webhook", address: 'url',
                                             topic: 'pages/update',
                                             resource_id: nil,
                                             id: 11) }
    let(:webhook) { mock("Webhook", address: 'url',
                                    topic: 'pages/update',
                                    resource_id: nil) }

    before(:each) do
      store_endpoint.stub(:get).and_return(parsed_response)
    end

    it "gets all the existing webhooks" do
      store_endpoint.should_receive(:get).with('/webhooks')
      subject.registered?(webhook)
    end

    context "one of the returned webhooks the webhook we already have" do
      let(:existing_webhooks) { [existing_webhook] }

      it "returns true" do
        subject.registered?(webhook).should be_true
      end
    end

    context "the webhook we want is not registered" do
      it "returns false" do
        subject.registered?(webhook).should be_false
      end
    end
  end

  describe "#deregister" do
    let(:webhook) { mock("Webhook", id: 11) }

    it "makes a delete request to the endpoint" do
      store_endpoint.should_receive(:delete).with("/webhooks/11")
      subject.deregister(webhook)
    end
  end

  describe "registered_webhooks" do
    let(:parsed_response) { mock("Parsed Response", :parsed => existing_webhooks) }
    let(:existing_webhooks) { [existing_webhook] }
    let(:existing_webhook) { mock("Webhook", address: 'url',
                                             topic: 'pages/update',
                                             resource_id: nil,
                                             id: 11) }

    before(:each) do
      store_endpoint.stub(:get).and_return(parsed_response)
    end

    it "gets all the existing webhooks" do
      store_endpoint.should_receive(:get).with('/webhooks')
      subject.registered_webhooks
    end

    it "returns the existing webhooks" do
      subject.registered_webhooks.should == existing_webhooks
    end
  end
end
