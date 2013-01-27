require 'spec_helper'

describe CrystalApi::StorePrefs do
  describe ".from_json" do
    let(:json_hash) do
      JSON.parse(<<-STR)
{
  "store_prefs": {
    "buylist_email": "donald@crystalcommerce.com",
    "satisfaction_blurb": "Our #1 goal is making sure you''re happy with your purchase today. Happy customers come back soon and tell their friends. Its a win, win.",
    "enable_frontend_auto_translate": false,
    "logo_photo": {
      "photo": {
        "is_default": false,
        "urls": {
          "original": {
            "href": "http:\/\/crystalcommerce-development.s3.amazonaws.com\/photo\/arux\/file\/8e233b1f3da489341a9d55a1ca744556\/arux-banner.png"
          }
        }
      }
    },
    "return_blurb": "If your order ever arrives in less than expected condition, please promptly return it to us for a full refund. We take your business with us very seriously.",
    "time_zone": "Pacific Time (US & Canada)",
    "city": "Seattle",
    "hostname": "www.example.com",
    "customer_service_phone": "555-555-5555",
    "zip": "98125",
    "sales_tax": "9",
    "cancel": "14",
    "default_currency_code": "USD",
    "default_locale": "x-bork",
    "privacy_blurb": "We promise to never ever sell your personal private information to any 3rd party company! We hate spam too. Order today with confidence.",
    "enable_manual_credit_card_capture": false,
    "store_credit_multiplier": "1.3",
    "buylist_cancel_days": "0",
    "checkout_special_instructions": "",
    "default_exchange_rate": "1",
    "enable_buy_order_notifications": "1",
    "enable_buylist": true,
    "enable_bcc_buylist_confirmation_emails": false,
    "enable_tax_on_shipping": true,
    "enable_sort_by_price": true,
    "feedback_timespan": "14",
    "home_redirect": "\/catalog\/magic_singles-core_sets-magic_2012\/306",
    "phone": "555-555-5555",
    "state": "WA",
    "enable_referafriend": true,
    "address": "3400 NE 110th ST #B-1",
    "payment": "7",
    "contact_name": "Mr. Arux",
    "name": "Arux Gaming and Hobbies",
    "display_customer_service_phone": false,
    "enable_order_notifications": "2",
    "enable_account_approval": false,
    "enable_watermarking_of_product_photos": false,
    "watermark_photo": null,
    "country": "US",
    "contact_email": "donald@crystalcommerce.com",
    "buylist_reminder_days": "0",
    "hide_bank_transfer_details_in_emails": false,
    "enable_invoice_logo": false
  }
}
      STR
    end

    subject { CrystalApi::StorePrefs.from_json(json_hash) }

    its(:hostname) { should == "www.example.com" }
    its(:city) { should == "Seattle" }

    its(:return_blurb)                           { should == "If your order ever arrives in less than expected condition, please promptly return it to us for a full refund. We take your business with us very seriously." }
    its(:time_zone)                              { should == "Pacific Time (US & Canada)" }
    its(:customer_service_phone)                 { should == "555-555-5555" }
    its(:zip)                                    { should == "98125" }
    its(:sales_tax)                              { should == "9" }
    its(:cancel)                                 { should == "14" }
    its(:default_currency_code)                  { should == "USD" }
    its(:default_locale)                         { should == "x-bork" }
    its(:privacy_blurb)                          { should == "We promise to never ever sell your personal private information to any 3rd party company! We hate spam too. Order today with confidence." }
    its(:enable_manual_credit_card_capture)      { should == false }
    its(:store_credit_multiplier)                { should == "1.3" }
    its(:buylist_cancel_days)                    { should == "0" }
    its(:checkout_special_instructions)          { should == "" }
    its(:default_exchange_rate)                  { should == "1" }
    its(:enable_buy_order_notifications)         { should == "1" }
    its(:enable_buylist)                         { should == true }
    its(:enable_bcc_buylist_confirmation_emails) { should == false }
    its(:enable_tax_on_shipping)                 { should == true }
    its(:enable_sort_by_price)                   { should == true }
    its(:feedback_timespan)                      { should == "14" }
    its(:home_redirect)                          { should == "\/catalog\/magic_singles-core_sets-magic_2012\/306" }
    its(:phone)                                  { should == "555-555-5555" }
    its(:state)                                  { should == "WA" }
    its(:enable_referafriend)                    { should == true }
    its(:address)                                { should == "3400 NE 110th ST #B-1" }
    its(:payment)                                { should == "7" }
    its(:contact_name)                           { should == "Mr. Arux" }
    its(:name)                                   { should == "Arux Gaming and Hobbies" }
    its(:display_customer_service_phone)         { should == false }
    its(:enable_order_notifications)             { should == "2" }
    its(:enable_account_approval)                { should == false }
    its(:enable_watermarking_of_product_photos)  { should == false }
    its(:watermark_photo)                        { should == nil }
    its(:country)                                { should == "US" }
    its(:contact_email)                          { should == "donald@crystalcommerce.com" }
    its(:buylist_reminder_days)                  { should == "0" }
    its(:hide_bank_transfer_details_in_emails)   { should == false }
    its(:enable_invoice_logo)                    { should == false}
    its(:buylist_email) { should == "donald@crystalcommerce.com" }
    its(:satisfaction_blurb) { should == "Our #1 goal is making sure you''re happy with your purchase today. Happy customers come back soon and tell their friends. Its a win, win." }
    its(:enable_frontend_auto_translate) { should == false }

    its(:logo_photo) { should == 
      CrystalApi::Photo.new(is_default: false,
        urls: {"original" => {href: "http://crystalcommerce-development.s3.amazonaws.com/photo/arux/file/8e233b1f3da489341a9d55a1ca744556/arux-banner.png"}})
    }
  end
end
