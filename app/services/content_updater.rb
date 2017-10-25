class ContentUpdater
  def initialize(content)
    @content = content
    @update_worker = ContentBasedFiltering::UpdateSingleContentWorker
    @destroy_worker = ContentBasedFiltering::DestroyContentWorker
  end

  def save
    if @content.save
      @update_worker.perform_async(@content.id)
    end
  end

  def destroy
    content_values = values_for_destroy
    if @content.destroy
      @destroy_worker.perform_async(content_values[:content_id], content_values[:content_type],
        content_values[:personality_ids], content_values[:user_ids])
    end
  end

  private

  def values_for_destroy
    {
      content_id: @content.id,
      content_type: @content.type,
      personality_ids: @content.personality_ids,
      user_ids: @content.rated_user_ids
    }
  end
end