module Cleo
  module Resque
    module Update
      @queue = Cleo::Server.queue

      def self.perform(klass, klass_id)
        to_delete = Kernel.const_get(klass).find(klass_id)
        Cleo.delete(to_delete.cleo_id)
        cr = Cleo::Reference.find(:first, :conditions => ["record_type = ? and record_id = ?", klass, to_delete.id])
        cr.delete
      end
    end
  end
end
