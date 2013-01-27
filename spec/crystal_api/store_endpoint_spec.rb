require 'spec_helper'

describe CrystalApi::StoreEndpoint, :vcr do
  subject { CrystalApi::StoreEndpoint.new(base_url: "http://localhost:3000/api/v1",
                                          token: "TOKEN") }

  its(:base_url) { should == "http://localhost:3000/api/v1" }
  its(:token) { should == "TOKEN" }
  its(:headers) { should == {"Authorization" => "OAuth TOKEN"} }

  describe "#get" do
    context "/prefs/store" do
      it "makes the request to the endpoint" do
        subject.get("/prefs/store")
        a_request(:get, "http://localhost:3000/api/v1/prefs/store").
          should have_been_made
      end

      it "parses the returned a store pref" do
        subject.get("/prefs/store").parsed.should be_a(CrystalApi::StorePrefs)
      end
    end
  end
end
