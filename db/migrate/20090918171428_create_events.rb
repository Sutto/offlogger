class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string     :name
      t.text       :message
      t.datetime   :occured_at
      t.belongs_to :nick
      t.timestamps
    end
    add_index :events, :nick_id
    add_index :events, :occured_at
    add_index :events, :name
    add_index :events, [:name, :nick_id]
    add_index :events, [:name, :occured_at]
  end

  def self.down
    drop_table :events
  end
end
