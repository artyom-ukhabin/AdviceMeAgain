class AddPostUserReference < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :author_id, :integer
    add_index :posts, :author_id
    add_foreign_key :posts, :users, column: :author_id
  end
end
