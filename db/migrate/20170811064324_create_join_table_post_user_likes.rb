class CreateJoinTablePostUserLikes < ActiveRecord::Migration[5.0]
  def change
    create_join_table :users, :posts, table_name: :posts_users_likes do |t|
      t.index :user_id
      t.index :post_id #TODO: think about indexes here
    end
  end
end
