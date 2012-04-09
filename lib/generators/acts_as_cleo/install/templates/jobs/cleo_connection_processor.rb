module Cleo
  module ConnectionProcessor
    @queue = Cleo::ConnectionServer.queue
    def self.perform(operation, klass, klass_id)
      on_me = Kernel.const_get(klass).find(klass_id)

      case operation.downcase
      when "create"
        Cleo::ConnectionServer.execute_create(on_me)
      when "update"
        Cleo::ConnectionServer.execute_update(on_me)
      when "delete"
        Cleo::ConnectionServer.execute_delete(on_me)
      end
    end
  end
end
