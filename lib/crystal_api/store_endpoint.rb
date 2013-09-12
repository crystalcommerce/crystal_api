require 'rest_client'
require 'values'

module CrystalApi
  class StoreEndpoint
    attr_reader :base_url, :token

    class Response < Value.new(:parsed, :raw, :json)
      alias_method :to_hash, :json

      def to_s
        "<CrystalApi::StoreEndpoint::Response parsed:#{parsed.class.name} raw.length:#{raw.length}>"
      end
    end

    def initialize(args = {})
      @base_url = args[:base_url]
      @token = args[:token]
    end

    def headers
      {
        "Authorization"    => "OAuth #{token}",
        "Accept"           => "application/json",
        "Content-Type"     => "application/json",
        "X-Requested-With" => "XMLHttpRequest"
      }
    end

    [:get, :delete].each do |method|
      define_method(method) do |path|
        raw = RestClient.public_send(method, base_url + path, headers)

        wrap_response(raw)
      end
    end

    [:post, :put].each do |method|
      define_method(method) do |path, payload|
        raw = RestClient.public_send(method, base_url + path, payload, headers)

        wrap_response(raw)
      end
    end

    private

    def wrap_response(raw)
      json = JSON.parse(raw)
      parsed = parse_response_body(json)

      Response.new(parsed, raw, json)
    end

    def parse_response_body(json)
      if json.is_a?(Array)
        json.map {|obj| parse(obj)}
      else
        parse(json)
      end
    rescue JSON::ParserError
      nil
    end

    def parse(object)
      CrystalApi.from_json(object)
    end
  end
end
