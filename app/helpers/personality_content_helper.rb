module PersonalityContentHelper
  def content_type_pluralized(type)
    type.pluralize
  end

  def options_for_personality_content(related_content)
    options_from_collection_for_select(
      related_content,
      :id,
      :name,
      selected_personalities(related_content)
    )
  end

  private

  def selected_content(related_content)
    related_content.map(&:id)
  end
end
