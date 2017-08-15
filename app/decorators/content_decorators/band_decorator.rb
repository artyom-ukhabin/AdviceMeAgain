module ContentDecorators
  class BandDecorator < BaseDecorator
    def subclass_index_data(band, user)
      additional_data = {}
      additional_data[:albums_collection] = build_album_collection(band)
      additional_data
    end

    private

    def build_album_collection(band)
      albums_collection = []
      band.albums.each do |album|
        current_album = {}
        current_album[:album] = album
        current_album[:tracks] = album.tracks
        albums_collection << current_album
      end
      albums_collection
    end
  end
end