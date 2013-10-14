module CrystalApi
  class ErrorResponse

    attr_reader :json
    def initialize(json)
      @json = json
    end

    def error
      json['error']
    end

    def description
      json['description']
    end
  end
end
