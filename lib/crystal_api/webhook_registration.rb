module CrystalApi
  class WebhookRegistration
    attr_reader :endpoint

    def initialize(endpoint)
      @endpoint = endpoint
    end

    def register(webhook)
      endpoint.post('/webhooks', webhook.to_json(:except => [:id]))
    end

    def registered?(webhook)
      registered_webhooks.any? {|wh| wh.address == webhook.address &&
                                     wh.topic   == webhook.topic &&
                                     wh.resource_id == webhook.resource_id }
    end

    def deregister(webhook)
      endpoint.delete("/webhooks/#{webhook.id}")
    end

    def registered_webhooks
      endpoint.get('/webhooks').parsed
    end

    def webhook_id(webhook)
      wh = registered_webhooks.detect {|wh| wh.address == webhook.address &&
                                       wh.topic   == webhook.topic &&
                                       wh.resource_id == webhook.resource_id }
      wh && wh.id
    end
  end
end
