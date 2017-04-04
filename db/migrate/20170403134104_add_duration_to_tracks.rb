class AddDurationToTracks < ActiveRecord::Migration[5.0]
  def change
    add_column :tracks, :duration, :integer
  end
end
