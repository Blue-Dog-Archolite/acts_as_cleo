module Cleo
  module Resque
    module Update
      @queue = Cleo::Server.queue

      def self.perform(klass, klass_id)
        to_update = Kernel.const_get(klass).find(klass_id)
        Cleo.update(to_update)
      end
    end
  end
end
