module ContentBasedFiltering
  class UpdateUserContentPreferencesWorker
    include Sidekiq::Worker

    def perform(content_id, user_id)
      updater = set_updater
      user = set_user(user_id)
      content_type = set_content_type(content_id)
      updater.update_user_data(user, content_type)
    end

    private

    def set_user(user_id)
      User.find user_id
    end

    def set_content_type(content_id)
      Content.type_for_id(content_id)
    end

    def set_updater
      ContentBasedFiltering::ItemUpdaters::ContentUpdater.new
    end
  end
end
