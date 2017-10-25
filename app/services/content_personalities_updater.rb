class ContentPersonalitiesUpdater
  def initialize(content)
    @content = content
    @worker_class = ContentBasedFiltering::UpdatePersonalityForContentTypeWorker
  end

  def personality_ids=(personality_ids)
    old_ids = @content.personality_ids
    difference_present = old_ids != personality_ids
    @content.personality_ids = personality_ids
    update_personalities(old_ids, personality_ids) if difference_present
  end

  def update_personalities(old_ids, personality_ids)
    personality_ids = personality_ids.map(&:to_i)
    @worker_class.perform_async(old_ids, personality_ids, @content.type)
  end
end