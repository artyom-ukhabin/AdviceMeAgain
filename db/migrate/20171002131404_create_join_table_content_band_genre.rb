class CreateJoinTableContentBandGenre < ActiveRecord::Migration[5.0]
  def change
    create_join_table :content, :band_genres do |t|
      # t.index [:content_id, :band_genre_id]
      # t.index [:band_genre_id, :content_id]
    end
  end
end
