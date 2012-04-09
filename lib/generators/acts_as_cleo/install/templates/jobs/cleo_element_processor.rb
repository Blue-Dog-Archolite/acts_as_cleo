module Cleo
  module ElementProcessor
    @queue = Cleo::ElementServer.queue
    def self.perform(operation, klass, klass_id)
      on_me = Kernel.const_get(klass).find(klass_id)
      case operation.downcase
      when "create"
        Cleo::ElementServer.execute_create(on_me)
      when "update"
        Cleo::ElementServer.execute_update(on_me)
      when "delete"
        Cleo::ElementServer.execute_delete(on_me)
      end
    end
  end
end
