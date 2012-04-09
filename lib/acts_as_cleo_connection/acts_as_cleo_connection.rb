#Load Cleo
require File.dirname(__FILE__ + '/cleo')

#Load CleoConnection modules
%w{acts_methods class_methods instance_methods}.each do |l|
  require File.dirname(__FILE__ + "/acts_as_cleo_connection/#{l}"
end

module ActsAsCleoConnection
  include ActsMethods
end

ActiveRecord::Base.extend ActsAsCleoConnection
