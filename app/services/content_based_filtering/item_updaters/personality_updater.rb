module ContentBasedFiltering
  module ItemUpdaters
    #TODO: maybe refactor
    class PersonalityUpdater
      PERSONALITY_TYPE = Personality::TYPE

      def initialize
        @personality_vector_object = VectorObjects::Personality.new
        @user_updater = ItemUpdaters::UserPersonalitiesUpdater.new
        @recommendations_updater = ItemUpdaters::PersonalityRecommendationsUpdater.new
      end

      def with_genre_update(content_array)
        types_for_update = get_types_from_content_ids([], content_array)
        update_personalities_array(types_for_update)
        update_users { |user| @user_updater.update_for_several_types(user, types_for_update) }
      end

      def update_for_ids_and_type(personality_ids, content_type)
        Personality.find(personality_ids).each do |personality|
          update_for_content_type(personality, content_type)
        end
      end

      def update(personality)
        update_personality(personality)
        types_for_update = personality.related_content_types
        update_related_users(personality) { |user| @user_updater.update_for_several_types(user, types_for_update) }
        update_recommendations_for_types(types_for_update)
      end

      def update_for_content_type(personality, content_type)
        update_personality_for_content_type(personality, content_type)
        update_related_users(personality) { |user| @user_updater.update_for_content_type(user, content_type) }
        update_recommendations_for_type(content_type)
      end

      def update_with_content_array(personality, old_content_ids, new_content_ids)
        types_for_update = get_types_from_content_ids(old_content_ids, new_content_ids)
        update_personality_with_several_types(personality, types_for_update)
        update_related_users(personality) { |user| @user_updater.update_for_several_types(user, types_for_update) }
        update_recommendations_for_types(types_for_update)
      end

      def update_user_data(personality, user)
        types_for_update = personality.related_content_types
        @user_updater.update_for_several_types(user, types_for_update)
        update_recommendations_for_types(types_for_update)
      end

      def destroy(personality_id, user_ids, types_for_update)
        @personality_vector_object.destroy_by_id(personality_id)
        all_vector_types = Content::TYPES.map(&:capitalize)
        update_users_by_ids(user_ids, types_for_update)
        update_recommendations_for_types(all_vector_types)
      end

      private

      def update_personalities_array(types_for_update)
        Personality.all.each do |personality|
          update_personality_with_several_types(personality, types_for_update)
        end
      end

      def get_types_from_content_ids(old_content_ids, new_content_ids)
        deleted_content_ids = old_content_ids - new_content_ids
        new_content_ids = new_content_ids - old_content_ids
        Content.distinct_types_for_ids(deleted_content_ids + new_content_ids)
      end

      def update_personality(personality)
        @personality_vector_object.update(personality)
      end

      def update_personality_for_content_type(personality, content_type)
        @personality_vector_object.update_for_content_type(personality, content_type)
      end

      def update_personality_with_several_types(personality, types_for_update)
        @personality_vector_object.update_with_several_types(personality, types_for_update)
      end

      def update_users_by_ids(user_ids, types_for_update)
        @user_updater.update_for_ids_and_types(user_ids, types_for_update)
      end

      def update_users
        User.all.each do |user|
          yield user
        end
      end

      def update_related_users(personality)
        personality.rated_users.each do |user|
          yield user
        end
      end

      def update_all_related_recommendations
        User.all.each do |user|
          @recommendations_updater.update_for_several_types(user, types_for_update)
        end
      end

      def update_recommendations_for_type(content_type)
        User.all.each do |user|
          @recommendations_updater.update(user, content_type)
        end
      end

      def update_recommendations_for_types(types_for_update)
        User.all.each do |user|
          @recommendations_updater.update_for_several_types(user, types_for_update)
        end
      end
    end
  end
end