#load Cleo Module for result and server
require File.dirname(__FILE__) + '/cleo'

#Load ActsAsCleo method load
require File.dirname(__FILE__) + '/acts_as_cleo/acts_methods'
require File.dirname(__FILE__) + '/acts_as_cleo/class_methods'
require File.dirname(__FILE__) + '/acts_as_cleo/instance_methods'

module ActsAsCleo
  include ActsMethods

end

ActiveRecord::Base.extend ActsAsCleo
