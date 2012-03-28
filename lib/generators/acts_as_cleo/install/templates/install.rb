class <%= migration_class_name %> < ActiveRecord::Migration
  def self.up
    create_table :references do
      t.timestamps
      t.string :record_type
      t.integer :record_id
    end
  end

  def down
    drop_table :references
  end
end
