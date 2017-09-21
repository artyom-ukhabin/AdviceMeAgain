class PersonalityContentDecorator
  def content_data(personality)
    content_data = {}
    content_data[:personality_id] = personality.id
    content_data[:related_content_data] = personality.grouped_content
    content_data
  end

  #TODO: think about grouped options too for the select2 images case
  def new_relations_data(personality)
    new_relations_data = {}
    new_relations_data[:personality_id] = personality.id
    new_relations_data[:related_content_data] = personality.content
    new_relations_data
  end
end