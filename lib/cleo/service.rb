module Cleo
  class Service < Cleo::Base


    def self.connection_server_url
      return Cleo::ConnectionServer.url.blank? ? nil : Cleo::ConnectionServer.url
    end

    def self.element_server_url
      return Cleo::ElementServer.url.blank? ? nil : Cleo::ElementServer.url
    end

  end
end
