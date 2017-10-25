class PersonalityUpdater
  def initialize(personality)
    @personality = personality
    @update_worker = ContentBasedFiltering::UpdatePersonalityWorker
    @destroy_worker = ContentBasedFiltering::DestroyPersonalityWorker
  end

  def save
    if @personality.save
      @update_worker.perform_async(@personality.id)
    end
  end

  def destroy
    personality_values = values_for_destroy
    if @personality.destroy
      @destroy_worker.perform_async(personality_values[:personality_id], personality_values[:user_ids],
        personality_values[:types_for_update])
    end
  end

  private

  def values_for_destroy
    {
      personality_id: @personality.id,
      user_ids: @personality.rated_user_ids,
      types_for_update: @personality.related_content_types
    }
  end
end