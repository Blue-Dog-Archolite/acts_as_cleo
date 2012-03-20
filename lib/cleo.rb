module Cleo

  def self.net_http
    @net_http if @net_http

    @uri = URI.parse(Cleo::Server.url)
    raise @uri
    require 'ruby-debug'
    debugger

    @net_http = Net::HTTP.new(@uri.host, @uri.port)
  end

  def self.get(uri)
    response = net_http.request(Net::HTTP::Get.new(uri.request_uri))

    return response if response.code ==  "200" # Net::HTTPOK
  end

  def self.find(id)
    #query by element/id to get from cleo fast
    uri = URI.parse(Cleo::Server.url + "#{id}")
    response = self.get(uri)

    Cleo::Result.parse(response.body, :single => true)
  end

  def self.query(query_param)
    uri = URI.parse(Cleo::Server.url + "search?query=#{CGI::escape query_param}")
    response = self.get(uri)

    Cleo::Result.parse(response.body, :single => false)
  end


  def self.update(obj)
    obj = obj.to_cleo_result unless obj.is_a?(Cleo::Result)

    uri = URI.parse Cleo::Server.url + "#{obj.id}"
    request = Net::HTTP::Post.new(uri.path)

    request.body = obj.to_xml
    request.content_type = 'application/xml'
    response = Net::HTTP.new(uri.host, uri.port).start { |http| http.request request }

    return response.code == Net::HTTPOK
  end

  def self.delete(obj)
    obj = obj.to_cleo_result unless obj.is_a?(Cleo::Result)
    uri = URI.parse Cleo::Server.url + "#{obj.id}"

    request = Net::HTTP::Delete.new("#{obj.id}")
    request.content_type = 'application/xml'
    response = Net::HTTP.new(uri.host, uri.port).start { |http| http.request request }

    return response.code == Net::HTTPOK
  end

  def self.create(obj)
    obj = obj.to_cleo_result unless obj.is_a?(Cleo::Result)

    uri = URI.parse Cleo::Server.url + "_"
    request = Net::HTTP::Post.new(uri.path)

    request.body = obj.to_xml
    request.content_type = 'application/xml'

    response = Net::HTTP.new(uri.host, uri.port).start { |http| http.request request }

    return response.code == "200"
  end
end

#require Result Class
require 'cleo/server'
require 'cleo/result'
