class CreateUser < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.integer :userid
      t.integer :count
      t.string :url
      t.timestamps
    end
  end
  def self.down
    drop_table :users
  end
end
