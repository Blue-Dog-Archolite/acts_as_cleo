module Cleo
  class Server
    @@server_location = {:url => 'http://cleo.testingserver.com/cleo-primer/' }

    def self.server_locations=(new_locations)
      parts = new_locations[:url].split("/")
      parts -=  %w{rest elements}
      parts +=  %w{rest elements}
      @@server_location[:url] = parts.join('/') + '/'
    end

    def self.url
      @@server_location[:url]
    end
  end
end
