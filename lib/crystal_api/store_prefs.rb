module CrystalApi
  class StorePrefs
    include Attributes

    root_element :store_prefs

    string_attribute :city
    string_attribute :hostname
    string_attribute :return_blurb
    string_attribute :time_zone
    string_attribute :customer_service_phone
    string_attribute :zip
    string_attribute :sales_tax
    string_attribute :cancel
    string_attribute :default_currency_code
    string_attribute :default_locale
    string_attribute :privacy_blurb
    string_attribute :store_credit_multiplier
    string_attribute :buylist_cancel_days
    string_attribute :checkout_special_instructions
    string_attribute :default_exchange_rate
    string_attribute :feedback_timespan
    string_attribute :home_redirect
    string_attribute :phone
    string_attribute :state
    string_attribute :address
    string_attribute :payment
    string_attribute :contact_name
    string_attribute :name
    string_attribute :watermark_photo
    string_attribute :country
    string_attribute :contact_email
    string_attribute :buylist_reminder_days
    string_attribute :enable_order_notifications
    string_attribute :enable_buy_order_notifications
    string_attribute :buylist_email
    string_attribute :satisfaction_blurb

    boolean_attribute :display_customer_service_phone
    boolean_attribute :hide_bank_transfer_details_in_emails
    boolean_attribute :enable_manual_credit_card_capture
    boolean_attribute :enable_buylist
    boolean_attribute :enable_bcc_buylist_confirmation_emails
    boolean_attribute :enable_tax_on_shipping
    boolean_attribute :enable_sort_by_price
    boolean_attribute :enable_referafriend
    boolean_attribute :enable_account_approval
    boolean_attribute :enable_watermarking_of_product_photos
    boolean_attribute :enable_invoice_logo
    boolean_attribute :enable_frontend_auto_translate

    object_attribute :logo_photo
  end
end
