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


    private int source;
    private int target;
    private boolean active;
    private int strength;
    private long timestamp;
    private String type;
