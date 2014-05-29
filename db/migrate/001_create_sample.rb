class CreateSample < ActiveRecord::Migration
  def self.up
    create_table :samples do |t|
      t.string :body
      t.timestamps
    end
  end
  def self.down
    drop_table :samples
  end
end
