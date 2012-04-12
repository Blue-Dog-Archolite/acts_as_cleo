#Load ActsAsCleoConnection files
require File.dirname(__FILE__) + '/acts_methods'
require File.dirname(__FILE__) + '/instance_methods'

module ActsAsCleoConnection
  include ActsMethods
end

ActiveRecord::Base.extend ActsAsCleoConnection
