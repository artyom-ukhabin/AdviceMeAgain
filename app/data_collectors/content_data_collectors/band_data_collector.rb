module ContentDataCollectors
  class BandDataCollector
    def collect(band)
      album_collection = []
      band.albums.each do |album|
        current_album = {}
        current_album[:album] = album
        current_album[:tracks] = album.tracks
        album_collection << current_album
      end

      collection = {}
      collection[:content] = band
      collection[:albums_collection] = album_collection
      collection
    end
  end
end