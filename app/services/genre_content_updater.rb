class GenreContentUpdater
  def initialize(genre)
    @genre = genre
    @worker_class = ContentBasedFiltering::UpdateMultiplyContentWorker
  end

  def content_ids=(content_ids)
    old_ids = @genre.content_ids
    difference_present = @genre.content_ids != content_ids
    @genre.content_ids = content_ids
    update_content(old_ids, content_ids) if difference_present
  end

  def update_content(old_ids, content_ids)
    content_ids = content_ids.map(&:to_i)
    @worker_class.perform_async(old_ids, content_ids)
  end
end