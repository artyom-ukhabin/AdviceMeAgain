module ContentBasedFiltering
  class UpdatePersonalityWorker
    include Sidekiq::Worker

    def perform(personality_id)
      personality = set_personality(personality_id)
      personality_filtering_service = set_filtering_service
      personality_filtering_service.update(personality)
    end

    private

    def set_personality(personality_id)
      Personality.find personality_id
    end

    def set_filtering_service
      ContentBasedFiltering::ItemUpdaters::PersonalityUpdater.new
    end
  end
end
