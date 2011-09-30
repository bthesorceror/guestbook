class CreateWallPosts < ActiveRecord::Migration
  def self.up
    create_table :wall_posts do |t|
      t.integer :user_id
      t.text :body

      t.timestamps
    end
  end

  def self.down
    drop_table :wall_posts
  end
end
