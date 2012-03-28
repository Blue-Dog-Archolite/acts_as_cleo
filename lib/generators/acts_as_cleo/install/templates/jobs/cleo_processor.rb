module Cleo
  module Processor
    @queue = Cleo::Server.queue

    def self.perform(operation, klass, klass_id)
      on_me = Kernel.const_get(klass).find(klass_id)
      case operation.downcase
      when "create"
        Cleo.execute_create(on_me)
      when "update"
        Cleo.execute_update(on_me)
      when "delete"
        Cleo.execute_delete(on_me)
      end
    end
  end
end
