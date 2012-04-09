module ActsAsCleoConnection
  module InstanceMethods
    def create_cleo_connection
      Cleo::Connection.create(self)
    end

    def update_cleo_connection
      Cleo::Connection.update(self)
    end

    def remove_cleo_connection
      Cleo::Connection.delete(self)
    end

    def disable_cleo_connection
      Cleo::Connection.disable(self)
    end
  end
end
