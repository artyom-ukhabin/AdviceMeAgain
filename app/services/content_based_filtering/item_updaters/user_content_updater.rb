module ContentBasedFiltering
  module ItemUpdaters
    class UserContentUpdater
      def initialize
        @user_object = VectorObjects::UserContentPreference.new
        @recommendations_updater = ItemUpdaters::ContentRecommendationsUpdater.new
      end

      def update_for_ids_and_type(user_ids, content_type)
        User.find(user_ids).each do |user|
          update(user, content_type)
        end
      end

      def update(user, content_type)
        @user_object.update(user, content_type)
      end

      def destroy(user_id)
        @user_object.destroy(user_id)
        @recommendations_updater.destroy(user_id)
      end
    end
  end
end