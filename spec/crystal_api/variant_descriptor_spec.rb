require 'spec_helper'

describe CrystalApi::VariantDescriptor do
	describe ".from_json" do
		let(:json_hash) {{
			'variant_descriptor' => {
				'name' => 'Condition',
				'value' => 'Near Mint'
			}
		}}

		subject { CrystalApi::VariantDescriptor.from_json(json_hash) }
		its(:name) { should == 'Condition' }
		its(:value) { should == 'Near Mint' }
	end
end
