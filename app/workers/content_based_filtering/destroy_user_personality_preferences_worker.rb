module ContentBasedFiltering
  class DestroyUserPersonalityPreferencesWorker
    include Sidekiq::Worker

    def perform(user_id)
      updater = set_updater
      updater.destroy(user_id)
    end

    private

    def set_updater
      ContentBasedFiltering::ItemUpdaters::UserPersonalitiesUpdater.new
    end
  end
end