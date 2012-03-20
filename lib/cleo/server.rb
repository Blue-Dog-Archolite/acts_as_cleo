module Cleo
  class Server
    @@server_location = {:url => 'http://cleo.testingserver.com/cleo-primer/rest/elements/' }

    def self.url
      @@server_location[:url]
    end
  end
end
