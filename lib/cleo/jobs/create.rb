module Cleo
  module Resque
    module Update
      @queue = Cleo::Server.queue

      def self.perform(klass, klass_id)
        to_create = Kernel.const_get(klass).find(klass_id)
        Cleo.create(to_create)
      end
    end
  end
end
