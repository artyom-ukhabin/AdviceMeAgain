module ContentPersonalitiesHelper
  def options_for_content_personalities(related_personalities)
    options_from_collection_for_select(
      related_personalities,
      :id,
      :name,
      selected_personalities(related_personalities)
    )
  end

  private

  def selected_personalities(personalities)
    personalities.map(&:id)
  end
end
