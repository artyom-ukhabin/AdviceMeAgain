module ContentBasedFiltering
  class UpdatePersonalityWithContentArrayWorker
    include Sidekiq::Worker

    def perform(personality_id, old_content_ids, new_content_ids)
      personality = set_personality(personality_id)
      updater = set_updater
      updater.update_with_content_array(personality, old_content_ids, new_content_ids)
    end

    private

    def set_personality(personality_id)
      Personality.find personality_id
    end

    def set_updater
      ContentBasedFiltering::ItemUpdaters::PersonalityUpdater.new
    end
  end
end
