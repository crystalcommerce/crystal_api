require 'spec_helper'

describe CrystalApi::Money do
  describe ".from_json" do
    it "parses the json" do
      CrystalApi::Money.from_json({"money" => {"cents" => 500, "currency" => "USD"}}).
        should == Money.new(500, "USD")
    end
  end
end
