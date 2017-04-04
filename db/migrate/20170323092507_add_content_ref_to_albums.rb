class AddContentRefToAlbums < ActiveRecord::Migration[5.0]
  def change
    add_reference :albums, :content, foreign_key: true
  end
end
