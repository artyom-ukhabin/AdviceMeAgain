module ContentBasedFiltering
  class UpdateUserPersonalitiesPreferencesWorker
    include Sidekiq::Worker

    def perform(personality_id, user_id)
      updater = set_updater
      user = set_user(user_id)
      personality = set_personality(personality_id)
      updater.update_user_data(personality, user)
    end

    private

    def set_user(user_id)
      User.find user_id
    end

    def set_personality(personality_id)
      Personality.find personality_id
    end

    def set_updater
      ContentBasedFiltering::ItemUpdaters::PersonalityUpdater.new
    end
  end
end
