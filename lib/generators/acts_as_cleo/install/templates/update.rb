class <%= migration_class_name %> < ActiveRecord::Migration
  def up
    add_index :cleo_references, :record_type, :unique => false
  end

  def down
    remove_index :cleo_references, :column => :record_type
  end
end
