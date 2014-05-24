require 'spec_helper'

describe CrystalApi::StoreEndpoint do
  let(:user) { 'username' }
  let(:pass) { 'licensekey' }
  subject { CrystalApi::StoreEndpoint.new(base_url: "https://api.crystalcommerce.com/v1/stores/arux",
                                          username: user,
                                          license: pass) }

  it "requests and accepts json" do
    expect(subject.headers).to include({
      "Accept"           => "application/json",
      "Content-Type"     => "application/json",
    })
  end

  describe "#get" do
    context "/prefs/store", :vcr do
      it "makes the request to the endpoint" do
        subject.get("/prefs/store")
        a_request(:get, "https://#{user}:#{pass}@api.crystalcommerce.com/v1/stores/arux/prefs/store").
          should have_been_made
      end

      it "parses the returned a store pref" do
        subject.get("/prefs/store").parsed.should be_a(CrystalApi::StorePrefs)
      end
    end

    context "csv parsing" do
      before do
        stub_request(:get, "https://#{user}:#{pass}@api.crystalcommerce.com/v1/stores/arux/reports/1234/download").
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
