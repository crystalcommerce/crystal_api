module CrystalApi
  class Money < ::Money
    def self.from_json(hash)
      attrs = hash.fetch('money', {})
      ::Money.new(attrs.fetch('cents', 0), attrs.fetch('currency', 'USD'))
    end
  end
end
