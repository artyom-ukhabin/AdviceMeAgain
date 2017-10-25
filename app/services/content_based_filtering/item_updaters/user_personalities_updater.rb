module ContentBasedFiltering
  module ItemUpdaters
    class UserPersonalitiesUpdater
      def initialize
        @user_object = VectorObjects::UserPersonalitiesPreference.new
        @recommendations_updater = ItemUpdaters::PersonalityRecommendationsUpdater.new
      end

      def update_for_ids_and_types(user_ids, content_types)
        User.find(user_ids).each do |user|
          update_for_several_types(user, content_types)
        end
      end

      def update_for_content_type(user, content_type)
        @user_object.update(user, content_type)
      end

      def update_for_several_types(user, types_for_update)
        types_for_update.each { |content_type| @user_object.update(user, content_type) }
      end

      def destroy(user_id)
        @user_object.destroy(user_id)
        @recommendations_updater.destroy(user_id)
      end
    end
  end
end