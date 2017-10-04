class GenreContentDecorator
  def content_data(genre)
    content_data = {}
    content_data[:genre_id] = genre.id
    content_data[:related_content] = genre.content
    content_data
  end
end