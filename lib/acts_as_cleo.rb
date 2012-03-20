require 'active_record'
require 'active_support'

#require File.dirname(__FILE__) + '/cleo'
require File.dirname(__FILE__) + '/acts_methods'
require File.dirname(__FILE__) + '/class_methods'
require File.dirname(__FILE__) + '/instance_methods'
require File.dirname(__FILE__) + '/common_methods'

#require File.dirname(__FILE__) + '/deprecation'
#require File.dirname(__FILE__) + '/search_results'


module ActsAsCleo
  @@cleo_server_loction = {:url => 'http://localhost:8982/solr' }

#  extend ActiveSupport::Concern
end

=begin
ActiveRecord::Base.extend ActsAsCleo::ActsMethods

cleo_file_path = File.join( RAILS_ROOT, 'config', 'cleo.yml' )

if File.exists?( cleo_file_path )
  ActsAsCleo.cleo_server_loction = YAML::load_file( cleo_file_path )[RAILS_ENV].symbolize_keys
end
=end
