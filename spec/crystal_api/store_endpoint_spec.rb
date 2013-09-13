require 'spec_helper'

describe CrystalApi::StoreEndpoint do
  subject { CrystalApi::StoreEndpoint.new(base_url: "http://localhost:3000/api/v1",
                                          token: "TOKEN") }

  its(:base_url) { should == "http://localhost:3000/api/v1" }
  its(:token) { should == "TOKEN" }
  its(:headers) { should include("Authorization" => "OAuth TOKEN") }

  describe "#get" do
    context "/prefs/store", :vcr do
      it "makes the request to the endpoint" do
        subject.get("/prefs/store")
        a_request(:get, "http://localhost:3000/api/v1/prefs/store").
          should have_been_made
      end

      it "parses the returned a store pref" do
        subject.get("/prefs/store").parsed.should be_a(CrystalApi::StorePrefs)
      end
    end

    context "csv parsing" do
      before do
        stub_request(:get, "http://localhost:3000/api/v1/reports/1234/download").
          to_return(:body => "id,name\n1,Fred",
                    :headers => {:content_type => "text/csv"})
      end

      it "parses the response as a CSV" do
        response = subject.get("/reports/1234/download")
        response.parsed.should be_a(CSV::Table)
      end
    end
  end
end
