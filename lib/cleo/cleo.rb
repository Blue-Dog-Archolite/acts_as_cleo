#Load Cleo Sub Modules
require File.dirname(__FILE__) + '/base_server'
require File.dirname(__FILE__) + '/connection_server'
require File.dirname(__FILE__) + '/element_server'
require File.dirname(__FILE__) + '/service'


module Cleo
  @@net_http = nil

  def self.net_http
    @@net_http unless @@net_http.blank?
    uri = URI.parse(Cleo::Service.url)

    @@net_http = Net::HTTP.new(uri.host, uri.port)
  end

  def self.get(uri)
    response = net_http.request(Net::HTTP::Get.new(uri.request_uri))

    return response if good_response_code?(response)
  end

  def self.flush
    uri = URI.parse Cleo::Service.url + "flush"
    request = Net::HTTP::Post.new(uri.path)
    Net::HTTP.new(uri.host, uri.port).start { |http| http.request request }
  end


  def self.configure(new_config)
    parts = new_config[:url].split("/")
    parts -=  %w{rest elements connections}
    parts += %w{rest}

    Cleo::ElementServer.url = (parts + %w{elements}).join('/') + '/'
    Cleo::ConnectionServer.url = (parts + %w{connections}).join('/') + '/'

    if new_config.has_key?(:async)
      self.async = new_config[:async]
    elsif new_config.has_key?(:run_async)
      self.async = new_config[:run_async]
    else
      self.async = false
    end

    self.auto_flush = new_config.has_key?(:auto_flush) ? new_config[:auto_flush] : true
    self.queue = new_config.has_key?(:queue) ? new_config[:queue] : "cleo"

    if new_config.has_key?(:auto_enable_queue) && new_config[:auto_enable_queue]
      env = ENV['QUEUE'] || ''
      ENV['QUEUE'] = (env.split(',') << self.queue).uniq.join(',')
    end
  end

  def self.load_configuration
    cleo_file_path = File.join( Rails.root, 'config', 'cleo.yml' )

    if File.exists?( cleo_file_path )
      Cleo.configure(YAML::load_file( cleo_file_path )[Rails.env].symbolize_keys)
    end
  end
end
