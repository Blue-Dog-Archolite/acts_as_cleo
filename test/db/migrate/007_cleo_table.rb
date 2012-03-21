class CleoTable < ActiveRecord::Migration
  def up
    create_table :cleo_references , :force => true do |t|
      t.timestamps
      t.string :record_type
      t.integer :record_id
    end
  end

  def self.down
    drop_table :cleo_references
  end
end
