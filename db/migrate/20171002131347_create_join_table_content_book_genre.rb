class CreateJoinTableContentBookGenre < ActiveRecord::Migration[5.0]
  def change
    create_join_table :content, :book_genres do |t|
      # t.index [:content_id, :book_genre_id]
      # t.index [:book_genre_id, :content_id]
    end
  end
end
