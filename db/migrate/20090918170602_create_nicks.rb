class CreateNicks < ActiveRecord::Migration
  def self.up
    create_table :nicks do |t|
      t.string :name
      t.belongs_to :user
      t.timestamps
    end
    add_index :nicks, :user_id
  end

  def self.down
    drop_table :nicks
  end
end
