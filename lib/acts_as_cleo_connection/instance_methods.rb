module ActsAsCleoConnection
  module InstanceMethods
    def create_cleo_connection
      Cleo::ConnectionServer.create(self)
    end

    def update_cleo_connection
      Cleo::ConnectionServer.update(self)
    end

    def remove_cleo_connection
      Cleo::ConnectionServer.delete(self)
    end

    def disable_cleo_connection
      Cleo::ConnectionServer.disable(self)
    end

    def to_cleo_connection
      source = self.send("#{cleo_origin}")
      target = self.send("#{cleo_target}")
      is_active = self.respond_to?(:active) ? self.active : nil

      Cleo::Xml::Connection.new(:source => source.cleo_id,
                                         :target => target.cleo_id,
                                         :active => is_active,
                                         :strength => self.strength,
                                         :type => self.cleo_type
                                        )
    end

    alias :as_connection :to_cleo_connection

  end
end
