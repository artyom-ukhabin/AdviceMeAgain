class CreateJoinTablePostUser < ActiveRecord::Migration[5.0]
  def change
    create_table :posts_users do |t|
      t.integer :user_id
      t.integer :post_id
    end
    add_index :posts_users, :user_id
    add_index :posts_users, :post_id
    add_foreign_key :posts_users, :posts
    add_foreign_key :posts_users, :users
  end
end