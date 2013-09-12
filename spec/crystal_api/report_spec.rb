require 'spec_helper'

describe CrystalApi::Report do
  describe ".from_json" do
    let(:json_hash) {{
      "report" => {
        "id" => 123,
        "status" => "pending",
        "report_type" => "inventory_report",
        "updated_at" => "2012-06-05T16:32:16-07:00",
        "created_at" => "2012-06-05T16:32:16-07:00",
        "expires_at" => "2012-06-05T16:32:16-07:00",
        "_links" => {
          "download" => {"href" => "download.com"},
          "self" => {"href" => "self.com"}
        }
      }
    }}

    subject { CrystalApi::Report.from_json(json_hash) }

    its(:id) { should == 123 }
    its(:status) { should == "pending" }
    its(:report_type) { should == "inventory_report" }
    its(:updated_at) { should == DateTime.new(2012,6,5,16,32,16, Rational(-7,24)) }
    its(:created_at) { should == DateTime.new(2012,6,5,16,32,16, Rational(-7,24)) }
    its(:expires_at) { should == DateTime.new(2012,6,5,16,32,16, Rational(-7,24)) }
    its(:_links) { should == {
      "download" => CrystalApi::Url.new(href: "download.com"),
      "self" => CrystalApi::Url.new(href: "self.com")
    }}
  end
end
