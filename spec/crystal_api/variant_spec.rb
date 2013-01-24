require 'spec_helper'

describe CrystalApi::Variant do
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

  describe ".from_json" do
    let(:json_hash) {{
      'variant' => {
        'id'                     => 123,
        'is_default'             => false,
        'is_infinite_qty'        => false,
        'product_id'             => 123,
        'qty'                    => 2,
        'wtb_qty'                => 8,
        'sell_price'             => {'money' => {'cents' => 500, 'currency' => 'USD'}},
        'buy_price'              => {'money' => {'cents' => 100, 'currency' => 'USD'}},
        'store_credit_buy_price' => {'money' => {'cents' => 130, 'currency' => 'USD'}},
        'catalog_id'             => 'skusku',
        'descriptors' => [
          {
            'variant_descriptor' => {
              'name' => 'Condition',
              'value' => 'Near Mint',
            }
          }
        ]
      }}}
    subject { CrystalApi::Variant.from_json(json_hash) }
    its(:id) { should == 123 }
    its(:descriptors) { should == [
      CrystalApi::VariantDescriptor.new(name: 'Condition', value: 'Near Mint')
    ] }
		its(:sell_price) { should == Money.new(500) }
		its(:buy_price) { should == Money.new(100) }
		its(:store_credit_buy_price) { should == Money.new(130) }
  end
end
