require 'base64'
require 'openssl'
require 'cgi'

module CrystalApi
  module HmacRequestSigning
    def inject_signature_header(headers, signature)
      headers['X-Hmac-Sha256'] = signature
      headers
    end

    def request_signature(request)
      request.headers['X_HMAC_SHA256']
    end

    def hmac_sha256(key, message)
      digest = OpenSSL::HMAC.digest('sha256', key, message)
      # chomp -- the base64 encoded version will have a newline at the end
      Base64.encode64(digest).chomp
    end

    def sign_params(verb, host, path, secret_key, params)
      hmac_sha256(secret_key, serialized_params(verb, host, path, params))
    end

    def serialized_params(verb, host, path, params)
      [ verb.to_s.upcase,
        host,
        path,
        canonicalize_params(params) ].join("\n")
    end

    def canonicalize_params(params)
      # Make sure we have string keys, otherwise the sort does not work
      params.keys.sort.map do |key|
        [CGI.escape(key.to_s), CGI.escape(params[key].to_s)].join('=')
      end.join('&')
    end
  end
end
