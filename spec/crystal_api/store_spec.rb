require 'spec_helper'

describe CrystalApi::Store do
	describe "#from_json" do
		let(:json_hash) {{
			"store" => {
				"name"          => "Arux Gaming Store",
				"database_name" => "arux"
			}
		}}

		subject { CrystalApi::Store.from_json(json_hash) }

		its(:name)           { should == "Arux Gaming Store" }
		its(:database_name) { should == "arux" }
	end
end
