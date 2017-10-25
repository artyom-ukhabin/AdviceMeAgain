module ContentBasedFiltering
  class UpdatePersonalityForContentTypeWorker
    include Sidekiq::Worker

    def perform(old_ids, new_ids, content_type)
      ids_for_update = ids_for_update(old_ids, new_ids)
      ids_for_update.each do |personality_id|
        update_single_personality(personality_id, content_type)
      end
    end

    private

    def ids_for_update(old_ids, new_ids)
      deleted_ids = old_ids - new_ids
      new_ids = new_ids - old_ids
      deleted_ids | new_ids
    end

    def update_single_personality(personality_id, content_type)
      personality = set_personality(personality_id)
      updater = set_updater
      updater.update_for_content_type(personality, content_type)
    end

    def set_personality(personality_id)
      Personality.find personality_id
    end

    def set_updater
      ContentBasedFiltering::ItemUpdaters::PersonalityUpdater.new
    end
  end
end
