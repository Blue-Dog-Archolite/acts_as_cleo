module Cleo
  class Server
    @@configuration= {:url => 'http://cleo.testingserver.com/cleo-primer/', :run_async => false, :queue => "cleo"}

    def self.configure(new_config)
      parts = new_config[:url].split("/")
      parts -=  %w{rest elements}
      parts +=  %w{rest elements}
      @@configuration[:url] = parts.join('/') + '/'

      @@configuration[:run_async] = new_config.has_key?(:run_async) ? new_config[:run_async] : false
      @@configuration[:queue] = new_config.has_key?(:queue) ? new_config[:queue] : "cleo"

      env = ENV['QUEUE'] || ''
      ENV['QUEUE'] = (env.split(',') << @@configuration[:queue]).uniq.join(',')
    end

    def self.load_configuration
      cleo_file_path = File.join( Rails.root, 'config', 'cleo.yml' )

      if File.exists?( cleo_file_path )
        Cleo::Server.configure(YAML::load_file( cleo_file_path )[Rails.env].symbolize_keys)
      end
    end

    #meta these out
    def self.url
      @@configuration[:url]
    end

    def self.async?
      @@configuration[:run_async]
    end

    def self.queue
      @@configuration[:queue].to_sym
    end
  end
end
