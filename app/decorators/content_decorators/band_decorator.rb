module ContentDecorators
  class BandDecorator
    def decorate(band, user)
      decorated_band = {}
      decorated_band[:subject] = band
      decorated_band[:albums_collection] = build_album_collection(band)
      decorated_band[:average_rating] = band.average_rating
      decorated_band[:user_rating] = band.rating(user)
      decorated_band
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