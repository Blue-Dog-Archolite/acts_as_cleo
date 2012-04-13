module Cleo
  class ConnectionServer < Cleo::Base
    cattr_accessor :url

    #define delete, update, create dynamically in order to set up reddis backed calls if enabled
    #Cleo.update(obj) will respect async settings
    %w{delete update create disable}.each do |mn|
      define_singleton_method(mn.to_s) do |obj|
        if Cleo::Service.async?
          Resque.enqueue(Cleo::ConnectionProcessor, mn,  obj.class.name, obj.id)
        else
          Cleo::ConnectionServer.send("execute_#{mn}".to_sym, obj)
        end
      end
    end

    def self.execute_create(con)
      obj = con.as_connection unless con.is_a?(Cleo::Xml::Connection)
      return true if obj.blank?

      uri = URI.parse Cleo::Service.connection_server_url + "_"
      request = Net::HTTP::Post.new(uri.path)

      request.body = obj.to_xml
      request.content_type = 'application/xml'

      response = Net::HTTP.new(uri.host, uri.port).start { |http| http.request request }

      return good_response_code?(response)
    end

    def self.execute_disable(con)
      sender = con.as_connection unless con.is_a?(Cleo::Xml::Connection)
      return true if sender.blank?

      sender.active = false

      return self.execute_update(sender)
    end

    def self.execute_delete(con)
      return self.execute_disable(con)
    end

    def self.execute_update(con)
      sender = con.as_connection unless con.is_a?(Cleo::Xml::Connection)
      return true if sender.blank?

      uri = URI.parse Cleo::Service.connection_server_url + "_"
      request = Net::HTTP::Post.new(uri.path)

      request.body = sender.to_xml
      request.content_type = 'application/xml'

      response = Net::HTTP.new(uri.host, uri.port).start { |http| http.request request }

      return good_response_code?(response)
    end

  end
end
