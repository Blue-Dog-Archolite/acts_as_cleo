module Cleo
  class Base
    @@configuration= {:url => 'http://cleo.testingserver.com/cleo-primer/', :run_async => false, :queue => "cleo"}

    def self.url
      @@configuration[:url]
    end

    def self.queue
      @@configuration[:queue].to_sym
    end

    def self.auto_flush?
      @@configuration[:auto_flush]
    end

    def self.async?
      @@configuration[:async]
    end


    def self.good_response_code?(response)
      case response
      when Net::HTTPOK
        flush if Cleo::Service.auto_flush?
        true   # success response
      when Net::HTTPClientError, Net::HTTPInternalServerError
        false  # non-success response
      end
    end
  end
end
