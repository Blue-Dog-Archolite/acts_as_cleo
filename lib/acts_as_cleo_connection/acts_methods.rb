module ActsAsCleoConnection
  module ActsMethods
    def acts_as_cleo_connection(opts = {})
      #push in Instance Methods
      include InstanceMethods

      after_create :create_cleo_connection
      after_update :update_cleo_connection
      before_destroy :remove_cleo_connection

      #Target and Origin calls
      cattr_accessor :cleo_target
      cattr_accessor :cleo_origin
      cattr_accessor :cleo_type
      cattr_accessor :cleo_strength

      #Set taggign calls
      self.cleo_origin = opts[:origin]
      self.cleo_target = opts[:target]
      self.cleo_type = opts[:type]
      self.cleo_strength = opts[:strengh]
    end
  end
end
