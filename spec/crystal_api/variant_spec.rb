require 'spec_helper'

describe CrystalApi::Variant do

  describe "#buy_price" do
    let(:attribute) { :buy_price }
    it_should_behave_like "money attribute"
  end

  describe "#sell_price" do
    let(:attribute) { :sell_price }
    it_should_behave_like "money attribute"
  end

  describe "#store_credit_buy_price" do
    let(:attribute) { :store_credit_buy_price }
    it_should_behave_like "money attribute"
  end

  describe "#id" do
    let(:attribute) { :id }
    it_should_behave_like "integer attribute"
  end

  describe "#product_id" do
    let(:attribute) { :product_id }
    it_should_behave_like "integer attribute"
  end

  describe "#qty" do
    let(:attribute) { :qty }
    it_should_behave_like "integer attribute"
  end

  describe "#wtb_qty" do
    let(:attribute) { :wtb_qty }
    it_should_behave_like "integer attribute"
  end

  describe "#catalog_id" do
    let(:attribute) { :catalog_id }
    it_should_behave_like "string attribute"
  end

  describe "#is_default" do
    let(:attribute) { :is_default }
    it_should_behave_like "boolean attribute"

    it "defines the default? method" do
      CrystalApi::Variant.new(is_default: true).default?.should == true
    end
  end

  describe "#is_infinite_qty" do
    let(:attribute) { :is_infinite_qty }
    it_should_behave_like "boolean attribute"

    it "defines the infinite_qty? method" do
      CrystalApi::Variant.new(is_infinite_qty: true).infinite_qty?.should == true
    end
  end
end
