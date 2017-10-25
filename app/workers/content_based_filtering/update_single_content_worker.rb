module ContentBasedFiltering
  class UpdateSingleContentWorker
    include Sidekiq::Worker

    def perform(content_id)
      content = set_content(content_id)
      content_filtering_service = set_filtering_service
      content_filtering_service.update_content_data(content)
    end

    private

    def set_content(content_id)
      Content.find content_id
    end

    #TODO: for personality
    def set_filtering_service
      ContentBasedFiltering::ItemUpdaters::ContentUpdater.new
    end
  end
end
