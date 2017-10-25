class ContentGenresDecorator
  def genres_data(content)
    genres_data = {}
    genres_data[:content_id] = content.id
    genres_data[:related_genres] = content.genres
    genres_data
  end
end