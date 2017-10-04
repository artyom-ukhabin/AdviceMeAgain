class CreateJoinTableContentMovieGenre < ActiveRecord::Migration[5.0]
  def change
    create_join_table :content, :movie_genres do |t|
      # t.index [:content_id, :movie_genre_id]
      # t.index [:movie_genre_id, :content_id]
    end
  end
end
