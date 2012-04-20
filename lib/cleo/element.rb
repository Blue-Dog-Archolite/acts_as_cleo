module Cleo
  class Element < ActiveRecord::Base
    self.table_name = 'cleo_references'
    attr_accessible :record_type, :record_id
  end
end
