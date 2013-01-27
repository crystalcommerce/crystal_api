module CrystalApi
  class WebhookVerifier
    include HmacRequestSigning

    attr_reader :secret_signing_key, :request

    def initialize(secret_signing_key, request)
      @secret_signing_key = secret_signing_key
      @request = request
    end

    def verified?
      request_signature(request) == expected_signature
    end

    def expected_signature
      hmac_sha256(secret_signing_key, request.raw_post)
    end
  end
end
