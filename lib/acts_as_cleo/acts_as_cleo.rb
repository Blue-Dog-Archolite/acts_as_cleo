#Load ActsAsCleo method load
require File.dirname(__FILE__) + '/acts_methods'
require File.dirname(__FILE__) + '/class_methods'
require File.dirname(__FILE__) + '/instance_methods'

module ActsAsCleo
  include ActsMethods

end

ActiveRecord::Base.extend ActsAsCleo
