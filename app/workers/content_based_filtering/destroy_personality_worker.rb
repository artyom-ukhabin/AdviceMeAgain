module ContentBasedFiltering
  class DestroyPersonalityWorker
    include Sidekiq::Worker

    def perform(personality_id, user_ids, types_for_update)
      updater = set_updater
      updater.destroy(personality_id, user_ids, types_for_update)
    end

    private

    def set_updater
      ContentBasedFiltering::ItemUpdaters::PersonalityUpdater.new
    end
  end
end
