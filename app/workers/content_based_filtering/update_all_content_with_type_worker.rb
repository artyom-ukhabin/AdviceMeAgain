module ContentBasedFiltering
  class WithGenreUpdateWorker
    include Sidekiq::Worker

    def perform(content_type)
      content_filtering_service = set_updater
      content_filtering_service.with_genre_update(content_type)
    end

    private

    def set_updater
      ContentBasedFiltering::ItemUpdaters::ContentUpdater.new
    end
  end
end