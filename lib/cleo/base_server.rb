module Cleo
  class Base
    cattr_accessor :async
    cattr_accessor :queue
    cattr_accessor :base_url
    cattr_accessor :auto_flush

    def self.async?
      async == true
    end

    def self.good_response_code?(response)
      case response
      when Net::HTTPOK
        flush if self.auto_flush?
        true   # success response
      when Net::HTTPClientError, Net::HTTPInternalServerError
        false  # non-success response
      end
    end
  end
end
