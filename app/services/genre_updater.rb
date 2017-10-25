class GenreUpdater
  def initialize(genre)
    @genre = genre
    @worker_class = ContentBasedFiltering::WithGenreUpdateWorker
  end

  def save
    if @genre.save
      update_content_based_info(@genre.content_type)
    end
  end

  def update(genre_params)
    if @genre.update(genre_params)
      update_content_based_info(@genre.content_type)
    end
  end

  def destroy
    type_for_update = @genre.content_type
    if @genre.destroy
      update_content_based_info(type_for_update)
    end
  end

  private

  def update_content_based_info(content_type)
    @worker_class.perform_async(content_type)
  end
end