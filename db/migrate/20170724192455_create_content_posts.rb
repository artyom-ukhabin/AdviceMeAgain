class CreateContentPosts < ActiveRecord::Migration[5.0]
  def change
    create_table :content_posts do |t|
      t.references :content, foreign_key: true
      t.references :post, foreign_key: true
      t.integer :position

      t.timestamps
    end
  end
end
