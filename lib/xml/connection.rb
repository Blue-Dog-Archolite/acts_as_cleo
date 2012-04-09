require 'happymapper'

module Cleo
  module Xml
    class Connection
      include HappyMapper
      tag 'connection'

      element :source, Integer
      element :target, Integer

      element :active, Boolean
      element :strength, Float
      element :timestamp, Time
      element :type, String
    end
  end
end
