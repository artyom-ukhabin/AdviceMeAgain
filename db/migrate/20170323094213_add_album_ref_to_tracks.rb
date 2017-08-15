class AddAlbumRefToTracks < ActiveRecord::Migration[5.0]
  def change
    add_reference :tracks, :album, foreign_key: true
  end
end
