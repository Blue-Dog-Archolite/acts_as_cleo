class <%= migration_class_name %> < ActiveRecord::Migration
  def self.up
    create_table :cleo_references do |t|
      t.timestamps
      t.string :record_type
      t.integer :record_id
    end
  end

  def down
    drop_table :cleo_references
  end
end
