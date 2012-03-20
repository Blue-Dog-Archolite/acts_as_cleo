CLEO_PATH = ENV['CLEO_HOME'] || "#{RAILS_ROOT}/config/cleo"

port = 8982
host = 'localhost'

if File.exists?( "#{RAILS_ROOT}/config/cleo.yml" )
  cleo_config = YAML.load( IO.read("#{RAILS_ROOT}/config/cleo.yml") )[ RAILS_ENV ]
  unless cleo_config.blank?
    config = cleo_config['url'].gsub( 'http://', '' ).split( '/' ).first.split(':')
    host = config.first
    port = config.last.to_i
  end
end

CLEO_HOST = host
CLEO_PORT = port
