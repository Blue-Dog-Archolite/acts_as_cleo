require 'happymapper'

module Cleo
  module Xml
    class Result
      include HappyMapper
      tag 'element'

      has_many :term, String, :tag => 'term'
      element :id, Integer
      element :name, String
      element :score, Float
      element :timestamp, Time
      element :title, String
      element :url, String

      alias :terms :term
    end
  end
end
