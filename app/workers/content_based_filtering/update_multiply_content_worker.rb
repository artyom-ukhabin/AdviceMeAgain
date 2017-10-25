module ContentBasedFiltering
  class UpdateMultiplyContentWorker
    include Sidekiq::Worker

    def perform(old_ids, new_ids)
      ids_for_update = ids_for_update(old_ids, new_ids)
      ids_for_update.each do |content_id|
        update_single_content(content_id)
      end
    end

    private

    def update_single_content(content_id)
      content = set_content(content_id)
      content_filtering_service = set_filtering_service
      content_filtering_service.update_content_data(content)
    end

    def ids_for_update(old_ids, new_ids)
      deleted_ids = old_ids - new_ids
      new_ids = new_ids - old_ids
      deleted_ids | new_ids
    end

    def set_content(content_id)
      Content.find content_id
    end

    #TODO: for personality
    def set_filtering_service
      ContentBasedFiltering::ItemUpdaters::ContentUpdater.new
    end
  end
end