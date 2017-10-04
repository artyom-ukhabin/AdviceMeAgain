module ContentGenresHelper
  def options_for_content_genres(related_genres)
    options_from_collection_for_select(
      related_genres,
      :id,
      :name,
      selected_genres(related_genres)
    )
  end

  private

  def selected_genres(genres)
    genres.map(&:id)
  end
end
