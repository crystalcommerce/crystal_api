require 'httparty'
require 'values'
require 'csv'

module CrystalApi
  class StoreEndpoint
    attr_reader :base_url, :token

    class Response < Value.new(:success, :parsed, :raw, :json)
      alias_method :to_hash, :json
      alias_method :success?, :success

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

    [:get, :delete, :post, :put].each do |method|
      define_method(method) do |*args|
        options = {:headers => headers}
        if args.length == 2
          options[:body] = args[1].to_json
        end

        path = args[0]
        url = base_url + path

        raw = HTTParty.public_send(method, url, options)
        wrap_response(raw)
      end
    end

    private

    def wrap_response(raw)
      if raw.content_type =~ /application\/json/
        json = JSON.parse(raw.body)
        if raw.code == 200
          parsed = parse_response_body(json)
        else
          parsed = error_response(json)
        end
      elsif raw.content_type =~ /text\/csv/
        parsed = CSV.parse(raw.body, :headers => true)
      end

      Response.new(raw.code == 200, parsed, raw, json)
    end

    def error_response(json)
      ErrorResponse.new(json)
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
