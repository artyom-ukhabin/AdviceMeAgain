class ContentPersonalitiesDecorator
  def personalities_data(content)
    personalities_data = {}
    personalities_data[:content_id] = content.id
    personalities_data[:related_personalities] = content.personalities
    personalities_data
  end
end