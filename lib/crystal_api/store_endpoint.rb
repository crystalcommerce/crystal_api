require 'httparty'
require 'values'
require 'csv'

module CrystalApi
  class StoreEndpoint
    attr_reader :base_url, :username, :license

    class Response < Value.new(:success, :parsed, :raw, :json)
      alias_method :to_hash, :json
      alias_method :success?, :success

      def to_s
        "<CrystalApi::StoreEndpoint::Response parsed:#{parsed.class.name} raw.length:#{raw.length}>"
      end
    end

    def initialize(args = {})
      @base_url = args[:base_url]
      @username = args[:username]
      @license = args[:license]
    end

    def headers
      {
        "Accept"           => "application/json",
        "Content-Type"     => "application/json",
        "X-Requested-With" => "XMLHttpRequest"
      }
    end

    [:get, :delete, :post, :put].each do |method|
      define_method(method) do |*args, &block|
        options = {
          :headers => headers,
          :basic_auth => {
            :username => username,
            :password => license
          }
        }
        if args.length == 2
          options[:body] = args[1].to_json
        end

        path = args[0]
        url = base_url + path

        if block.nil?
          raw = HTTParty.public_send(method, url, options)
          wrap_response(raw)
        else
          HTTParty.public_send(method, url, options, &block)
        end
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
