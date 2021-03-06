# CrystalApi

A library for using the CrystalCommerce API in Ruby. See
http://apidocs.crystalcommerce.com for API documentation.

## TODO

* Receiving Webhook payload verification
* Sending Webhook payload signing
* Switch to http client that the user of the gem can override the
  backend, so that async http calls can be made (faraday?)
* Remove git ls-files usage from gemspec
* Add usage documentation to apidocs site
* Define behavior for http responses (404, 403, 500, etc)
* Allow user of gem to specify json parsing library (MultiJSON)

## Installation

Add this line to your application's Gemfile:

    gem 'crystal_api'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install crystal_api

## Usage

    store_endpoint = CrystalApi::StoreEndpoint.new(
      base_url: "https://apitest-api.crystalcommerce.com/v1",
      token: "your-oauth2-token"
    )

    store_prefs = store_endpoint.get("/prefs/store")

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

See LICENSE.txt
