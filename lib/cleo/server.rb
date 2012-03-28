module Cleo
  class Server
    @@configuration= {:url => 'http://cleo.testingserver.com/cleo-primer/', :run_async => false, :queue => "cleo"}

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
        Cleo::Server.configure(YAML::load_file( cleo_file_path )[Rails.env].symbolize_keys)
      end
    end

    #meta these out
    def self.url
      @@configuration[:url]
    end

    def self.auto_flush?
      @@configuration[:auto_flush]
    end

    def self.async?
      @@configuration[:async]
    end

    def self.queue
      @@configuration[:queue].to_sym
    end
  end
end
