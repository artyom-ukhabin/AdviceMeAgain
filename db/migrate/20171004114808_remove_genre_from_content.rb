class RemoveGenreFromContent < ActiveRecord::Migration[5.0]
  def change
    remove_column :content, :genre, :string
  end
end
