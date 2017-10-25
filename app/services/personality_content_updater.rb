class PersonalityContentUpdater
  def initialize(personality)
    @personality = personality
    @worker_class = ContentBasedFiltering::UpdatePersonalityWithContentArrayWorker
  end

  def content_ids=(content_ids)
    old_ids = @personality.content_ids
    difference_present = old_ids != content_ids
    @personality.content_ids = content_ids
    update_personality(old_ids, content_ids) if difference_present
  end

  def update_personality(old_ids, new_ids)
    new_ids = new_ids.map(&:to_i)
    @worker_class.perform_async(@personality.id, old_ids, new_ids)
  end
end