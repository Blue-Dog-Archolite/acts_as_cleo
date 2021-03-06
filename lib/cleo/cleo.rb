#Load Cleo Sub Modules

require File.dirname(__FILE__) + '/base_server'
require File.dirname(__FILE__) + '/connection_server'
require File.dirname(__FILE__) + '/element_server'
require File.dirname(__FILE__) + '/service'
require File.dirname(__FILE__) + '/element'

require 'resque'


module Cleo
  def self.query(query)
    Cleo::ElementServer.query(query)
  end

  def self.network_query(source_id, query)
  end

  def self.net_http
    uri = URI.parse(Cleo::Service.url)
    Net::HTTP.new(uri.host, uri.port)
  end

  def self.get(uri)
    response = net_http.request(Net::HTTP::Get.new(uri.request_uri))

    return response if Cleo::Service.good_response_code?(response)
  end

  def self.flush
    Cleo.flush_elements and Cleo.flush_connections
  end

  def self.flush_connections
    uri = URI.parse Cleo::Service.connection_server_url + "flush"
    request = Net::HTTP::Post.new(uri.path)
    response = Net::HTTP.new(uri.host, uri.port).start { |http| http.request request }
    Cleo::Service.good_response_code?(response)
  end

  def self.flush_elements
    uri = URI.parse Cleo::Service.element_server_url + "flush"
    request = Net::HTTP::Post.new(uri.path)
    response = Net::HTTP.new(uri.host, uri.port).start { |http| http.request request }
    Cleo::Service.good_response_code?(response)
  end

  def self.configure(new_config)
    parts = new_config[:url].split("/")
    parts -=  %w{rest elements connections}
    parts += %w{rest}

    Cleo::Service.base_url = parts.join('/') + '/'

    Cleo::ElementServer.url = (parts + %w{elements}).join('/') + '/'
    Cleo::ConnectionServer.url = (parts + %w{connections}).join('/') + '/'

    if new_config.has_key?(:async)
      Cleo::Service.async = new_config[:async]
    elsif new_config.has_key?(:run_async)
      Cleo::Service.async = new_config[:run_async]
    else
      Cleo::Service.async = false
    end

    Cleo::Service.auto_flush = new_config.has_key?(:auto_flush) ? new_config[:auto_flush] : true
    Cleo::Service.queue = new_config.has_key?(:queue) ? new_config[:queue] : "cleo"

    if new_config.has_key?(:auto_enable_queue) && new_config[:auto_enable_queue]
      env = ENV['QUEUE'] || ''
      ENV['QUEUE'] = (env.split(',') << Cleo::Service.queue).uniq.join(',')
    end
  end

  def self.load_configuration
    cleo_file_path = File.join( Rails.root, 'config', 'cleo.yml' )

    if File.exists?( cleo_file_path )
      Cleo.configure(YAML::load_file( cleo_file_path )[Rails.env].symbolize_keys)
      true
    else
      raise ArgumentError.new("No configuration file found. Check for cleo.yml")
      false
    end
  end
end
