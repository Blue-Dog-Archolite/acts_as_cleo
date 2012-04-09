module Cleo
  module ConnectionServer
    #define delete, update, create dynamically in order to set up reddis backed calls if enabled
    #Cleo.update(obj) will respect async settings
    %w{delete update create disable}.each do |mn|
      define_singleton_method(mn.to_s) do |obj|
        if Cleo::Service.async?
          Resque.enqueue(Cleo::ConnectionProcessor, mn,  obj.class.name, obj.id)
        else
          Cleo::ConnectionServer.send("execute_#{mn}".to_sym, mn)
        end
      end
    end


    def self.execute_update(con)
#      obj = obj.to_cleo_result unless obj.is_a?(Cleo::Result)

#      uri = URI.parse Cleo::Service.url + "_"
#      request = Net::HTTP::Post.new(uri.path)

#      request.body = obj.to_xml
#      request.content_type = 'application/xml'

#      response = Net::HTTP.new(uri.host, uri.port).start { |http| http.request request }

#      return good_response_code?(response)
    end

    def self.execute_create(con)
    end

    def self.execute_disable(con)
    end

    alias :execute_disable, :execute_delete

  end
end
