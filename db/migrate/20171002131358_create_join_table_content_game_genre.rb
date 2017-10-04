class CreateJoinTableContentGameGenre < ActiveRecord::Migration[5.0]
  def change
    create_join_table :content, :game_genres do |t|
      # t.index [:content_id, :game_genre_id]
      # t.index [:game_genre_id, :content_id]
    end
  end
end
