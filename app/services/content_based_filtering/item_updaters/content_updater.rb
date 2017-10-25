module ContentBasedFiltering
  module ItemUpdaters
    class ContentUpdater
      def initialize
        @content_vector_object = VectorObjects::Content.new
        @personalities_updater = ItemUpdaters::PersonalityUpdater.new
        @user_updater = ItemUpdaters::UserContentUpdater.new
        @recommendations_updater = ItemUpdaters::ContentRecommendationsUpdater.new
      end

      def with_genre_update(content_type)
        content_array = Content.with_type(content_type)
        update_for_array(content_array)
        update_personalities_for_genre_update(content_array)
        update_users_for_type(content_type)
      end

      def update_content_data(content)
        @content_vector_object.update(content)
        update_related_personalities(content)
        update_related_users(content)
        update_recommendations(content.type)
      end

      def destroy(content_id, content_type, personality_ids, users_ids)
        @content_vector_object.destroy_by_id(content_id)
        update_personalities_by_ids_and_type(personality_ids, content_type)
        update_users_by_ids(users_ids, content_type)
        update_recommendations(content_type)
      end

      def update_user_data(user, content_type)
        update_user(user, content_type)
        update_recommendation(user, content_type)
      end

      private

      def update_for_array(content_array)
        content_array.each do |content|
          update_content(content)
        end
      end

      def update_personalities_for_genre_update(content_array)
        @personalities_updater.with_genre_update(content_array)
      end

      def update_personalities_by_ids_and_type(personality_ids, content_type)
        @personalities_updater.update_for_ids_and_type(personality_ids, content_type)
      end

      def update_users_for_type(content_type)
        User.all.each do |user|
          update_user(user, content_type)
        end
      end

      def update_content(content)
        @content_vector_object.update(content)
      end

      def update_related_users(content)
        content.rated_users.each do |user|
          update_user(user, content.type)
        end
      end

      def update_users_by_ids(user_ids, content_type)
        @user_updater.update_for_ids_and_type(user_ids, content_type)
      end

      def update_user(user, content_type)
        @user_updater.update(user, content_type)
      end

      def update_related_personalities(content)
        content.personalities.each do |personality|
          @personalities_updater.update_for_content_type(personality, content.type)
        end
      end

      def update_recommendation(user, content_type)
        @recommendations_updater.update(user, content_type)
      end

      def update_recommendations(content_type)
        @recommendations_updater.update_all_for_type(content_type)
      end
    end
  end
end