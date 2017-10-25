class ContentGenresUpdater
  def initialize(content)
    @content = content
    @worker_class = ContentBasedFiltering::UpdateSingleContentWorker
  end

  def genre_ids=(genre_ids)
    difference_present = @content.genre_ids != genre_ids
    @content.genre_ids = genre_ids
    update_content if difference_present
  end

  def update_content
    @worker_class.perform_async(@content.id)
  end
end