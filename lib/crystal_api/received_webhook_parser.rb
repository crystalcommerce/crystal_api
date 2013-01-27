module CrystalApi
  class ReceivedWebhookParser
    attr_reader :raw_post

    def initialize(raw_post)
      @raw_post = raw_post
    end

    def webhook
      WebhookEnvelope.from_json(json)
    end

    def json
      @json ||= JSON.parse(raw_post)
    end
  end
end
