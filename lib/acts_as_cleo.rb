#load Cleo Module for result and server
require File.dirname(__FILE__) + '/cleo'

#Load ActsAsCleo method load
require File.dirname(__FILE__) + '/acts_methods'
require File.dirname(__FILE__) + '/class_methods'
require File.dirname(__FILE__) + '/instance_methods'

module ActsAsCleo
  include ActsMethods
end

ActiveRecord::Base.extend ActsAsCleo

root_path = Rails.root.nil? ? "#{File.dirname(File.expand_path(__FILE__))}/../"  : Rails.root
cleo_file_path = File.join( root_path, 'config', 'cleo.yml' )

if File.exists?( cleo_file_path )
  Cleo::Server.server_locations = YAML::load_file( cleo_file_path )[Rails.env].symbolize_keys
else
  raise LoadError.new("No cleo.yml found. Please viery that you have a copy of cleo.yml in your config directory.")
end
