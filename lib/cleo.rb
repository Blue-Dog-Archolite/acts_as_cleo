module Cleo
  BASE_URL = "http://cleo.neighborhoods.com/cleo-primer/rest/elements/"

  def self.net_http
    @net_http if @net_http

    @uri = URI.parse(BASE_URL)
    @net_http = Net::HTTP.new(@uri.host, @uri.port)
  end

  def self.get(uri)
    response = net_http.request(Net::HTTP::Get.new(uri.request_uri))
    Utils::NetResponse.is_200_or_gtfo(response)

    return response
  end

  def self.find(id)
    #query by element/id to get from cleo fast
    uri = URI.parse(BASE_URL + "#{id}")
    response = self.get(uri)

    Cleo::Result.parse(response.body, :single => true)
  end

  def self.query(query_param)
    uri = URI.parse(BASE_URL + "search?query=#{CGI::escape query_param}")
    response = self.get(uri)

    Cleo::Result.parse(response.body, :single => false)
  end


  def self.update(obj)
    obj = obj.to_cleo_result unless obj.is_a?(Cleo::Result)

    uri = URI.parse BASE_URL + "#{obj.id}"
    request = Net::HTTP::Post.new(uri.path)

    request.body = obj.to_xml.html_safe
    request.content_type = 'application/xml'
    response = Net::HTTP.new(uri.host, uri.port).start { |http| http.request request }

    return Utils::NetResponse.is_200?(response)
  end

  def self.delete(obj)
    obj = obj.to_cleo_result unless obj.is_a?(Cleo::Result)

    request = Net::HTTP::Delete.new("#{obj.id}")
    response = net_http.request(request)

    return Utils::NetResponse.is_200?(response) #200 says deleted okay
  end

  def self.create(obj)
    obj = obj.to_cleo_result unless obj.is_a?(Cleo::Result)

    uri = URI.parse BASE_URL + "_"
    request = Net::HTTP::Post.new(uri.path)

    request.body = obj.to_xml.html_safe
    request.content_type = 'application/xml'

    response = Net::HTTP.new(uri.host, uri.port).start { |http| http.request request }

    return Utils::NetResponse.is_200?(response)
  end
end

#require Result Class
require 'cleo/result'
