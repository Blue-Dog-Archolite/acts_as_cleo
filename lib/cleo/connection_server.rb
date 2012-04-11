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
    end

    def self.execute_disable(con)
    end

    def self.execute_delete(con)
      self.execute_disable(con)
    end

    def self.execute_update(con)
      source = con.send("#{cleo_source}")
      target = con.send("#{cleo_target}")

      sender = Cleo::Xml::Connection.new(:source => source.cleo_id,
                                         :target => target.cleo_id,
                                         :active => con.active,
                                         :strength => con.strength,
                                         :type => con.cleo_type
                                        )

      uri = URI.parse Cleo::Service.connection_url + "_"
      request = Net::HTTP::Post.new(uri.path)

      request.body = sender.to_xml
      request.content_type = 'application/xml'

      response = Net::HTTP.new(uri.host, uri.port).start { |http| http.request request }

      return good_response_code?(response)
    end

  end
end
