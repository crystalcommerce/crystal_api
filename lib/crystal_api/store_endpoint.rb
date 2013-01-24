require 'rest_client'
require 'values'

module CrystalApi
  class StoreEndpoint
    attr_reader :base_url, :token

    class Response < Value.new(:parsed, :raw)
      def to_s
        "<CrystalApi::StoreEndPoint::Response parsed:#{parsed.class.name} raw.length:#{raw.length}>"
      end
    end

    def initialize(args = {})
      @base_url = args[:base_url]
      @token = args[:token]
    end

    def headers
      {
        'Authorization' => "OAuth #{token}"
      }
    end

    def get(path)
      raw = RestClient.get(base_url + path, headers)

      if raw.code == 200
        json = JSON.parse(raw)

        parsed = if json.is_a?(Array)
                   json.map {|obj| parse(obj)}
                 else
                   parse(json)
                 end
      end

      Response.new(parsed, raw)
    end

    private

    def parse(object)
      CrystalApi.from_json(object)
    end
  end
end
