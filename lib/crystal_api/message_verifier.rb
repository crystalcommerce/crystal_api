module CrystalApi
  class MessageVerifier
    include HmacRequestSigning

    attr_reader :shared_secret, :request

    def initialize(shared_secret, request)
      @shared_secret = shared_secret
      @request = request
    end

    def verified?
      request_signature(request) == expected_signature
    end

    def expected_signature
      rack_request = Rack::Request.new(request.env)

      sign_params(rack_request.request_method,
                  rack_request.host,
                  rack_request.path,
                  shared_secret,
                  rack_request.params)
    end
  end
end
