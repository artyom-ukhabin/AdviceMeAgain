module ContentBasedFiltering
  class DestroyContentWorker
    include Sidekiq::Worker

    def perform(content_id, content_type, personality_ids, user_ids)
      updater = set_updater
      updater.destroy(content_id, content_type, personality_ids, user_ids)
    end

    private

    def set_updater
      ContentBasedFiltering::ItemUpdaters::ContentUpdater.new
    end
  end
end
