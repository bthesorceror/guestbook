class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :uid
      t.string :provider
      t.string :nick
      t.string :avatar_url

      t.timestamps
    end
    
    add_index :users, [:uid, :provider], :unique => true
  end

  def self.down
    drop_table :users
  end
end
