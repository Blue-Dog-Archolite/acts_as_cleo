#load Cleo Module for result
require File.dirname(__FILE__) + '/cleo'

require File.dirname(__FILE__) + '/acts_methods'
require File.dirname(__FILE__) + '/class_methods'
require File.dirname(__FILE__) + '/instance_methods'
require File.dirname(__FILE__) + '/common_methods'

module ActsAsCleo

  extend ClassMethods
  include InstanceMethods
  include CommonMethods

end

ActiveRecord::Base.extend ActsAsCleo

root_path = Rails.root.nil? ? "#{File.dirname(File.expand_path(__FILE__))}/../../"  : Rails.root
cleo_file_path = File.join( root_path, 'config', 'cleo.yml' )

if File.exists?( cleo_file_path )
  Cleo::Server.server_location = YAML::load_file( cleo_file_path )[Rails.env].symbolize_keys
end
