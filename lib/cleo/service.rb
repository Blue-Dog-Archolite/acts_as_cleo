module Cleo
  class Service
    def self.connection_url
      return Cleo::ConnectionServer.url.blank? ? nil : Cleo::ConnectionServer.url
    end

    def self.element_url
      return Cleo::ElementServer.url.blank? ? nil : Cleo::ElementServer.url
    end
  end
end
