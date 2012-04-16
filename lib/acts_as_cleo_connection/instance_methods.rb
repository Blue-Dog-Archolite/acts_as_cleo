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
      type = self.respond_to?("#{cleo_type}") ? self.send("#{cleo_type}") : cleo_type
      return nil if target.blank? || source.blank?

      is_active = self.respond_to?(:active) ? self.active : nil
      str = target.score + source.score

      result = Cleo::Xml::Connection.new

      result.source = source.cleo_id
      result.target = target.cleo_id
      result.active = is_active
      result.strength = str
      result.type = type

      return result
    end

    alias :as_connection :to_cleo_connection

  end
end
