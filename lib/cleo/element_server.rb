module Cleo
  class ElementServer < Cleo::Base
    cattr_accessor :url

    #define delete, update, create dynamically in order to set up reddis backed calls if enabled
    #Cleo.update(obj) will respect async settings
    %w{delete update create}.each do |mn|
      define_singleton_method(mn.to_s) do |obj|
        if Cleo::Service.async?
          Resque.enqueue(Cleo::ElementProcessor, mn,  obj.class.name, obj.id)
        else
          Cleo::ElementServer.send("execute_#{mn}".to_sym, obj)
        end
      end
    end

    def self.find(id)
      #query by element/id to get from cleo fast
      uri = URI.parse(Cleo::Service.element_server_url + "#{id}")
      response = Cleo.get(uri)

      return nil if response.body.blank?

      Cleo::Xml::Result.parse(response.body, :single => true)
    end

    def self.query(query_param)
      uri = URI.parse(Cleo::Service.element_server_url + "search?query=#{CGI::escape query_param}")
      response = Cleo.get(uri)

      Cleo::Xml::Result.parse(response.body, :single => false)
    end

    def self.execute_update(obj)
      obj = obj.to_cleo_result unless obj.is_a?(Cleo::Xml::Result)

      uri = URI.parse Cleo::Service.element_server_url + "#{obj.id}"
      request = Net::HTTP::Put.new(uri.path)

      request.content_type = 'application/xml'
      request.body = obj.to_xml
      response = Net::HTTP.new(uri.host, uri.port).start { |http| http.request request }

      return good_response_code?(response)
    end

    def self.execute_delete(obj_or_id)
      cleo_id = nil

      if obj_or_id.is_a?(Fixnum)
        cleo_id = obj_or_id
      elsif obj_or_id.respond_to?("cleo_id")
        cleo_id = obj_or_id.cleo_id
      elsif obj_or_id.is_a?(Cleo::Xml::Result)
        cleo_id = obj_or_id.id
      end

      uri = URI.parse Cleo::Service.element_server_url + "#{cleo_id}"
      request = Net::HTTP::Delete.new(uri.path)

      response = Net::HTTP.new(uri.host, uri.port).start { |http| http.request request }

      return good_response_code?(response)
    end

    def self.execute_create(obj)
      obj = obj.to_cleo_result unless obj.is_a?(Cleo::Xml::Result)

      uri = URI.parse self.url + "_"
      request = Net::HTTP::Post.new(uri.path)

      request.body = obj.to_xml
      request.content_type = 'application/xml'

      response = Net::HTTP.new(uri.host, uri.port).start { |http| http.request request }

      return good_response_code?(response)
    end

  end
end
