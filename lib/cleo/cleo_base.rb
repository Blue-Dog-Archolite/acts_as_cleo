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
  end
end
