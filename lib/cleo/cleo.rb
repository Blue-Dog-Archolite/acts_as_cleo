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

  def self.good_response_code?(response)
    case response
    when Net::HTTPOK
      flush if Cleo::Service.auto_flush?
      true   # success response
    when Net::HTTPClientError, Net::HTTPInternalServerError
      false  # non-success response
    end
  end

  def self.configure(new_config)
    parts = new_config[:url].split("/")
    parts -=  %w{rest elements}
    parts +=  %w{rest elements}
    @@configuration[:url] = parts.join('/') + '/'

    if new_config.has_key?(:async)
      @@configuration[:async] = new_config[:async]
    elsif new_config.has_key?(:run_async)
      @@configuration[:async] = new_config[:run_async]
    else
      @@configuration[:async] = false
    end

    @@configuration[:auto_flush] = new_config.has_key?(:auto_flush) ? new_config[:auto_flush] : true
    @@configuration[:queue] = new_config.has_key?(:queue) ? new_config[:queue] : "cleo"

    if new_config.has_key?(:auto_enable_queue) && new_config[:auto_enable_queue]
      env = ENV['QUEUE'] || ''
      ENV['QUEUE'] = (env.split(',') << @@configuration[:queue]).uniq.join(',')
    end
  end

  def self.load_configuration
    cleo_file_path = File.join( Rails.root, 'config', 'cleo.yml' )

    if File.exists?( cleo_file_path )
      Cleo.configure(YAML::load_file( cleo_file_path )[Rails.env].symbolize_keys)
    end
  end
end
