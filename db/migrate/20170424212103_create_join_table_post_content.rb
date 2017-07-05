class CreateJoinTablePostContent < ActiveRecord::Migration[5.0]
  def change
    create_join_table :posts, :content do |t|
      # t.index [:post_id, :content_id]
      # t.index [:content_id, :post_id]
    end
  end
end
