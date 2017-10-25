module ContentBasedFiltering
  module ItemUpdaters
    class PersonalityRecommendationsUpdater
      def initialize
        @recommendations_object = VectorObjects::PersonalityRecommendations.new
      end

      def update_for_several_types(user, content_types)
        content_types.each do |content_type|
          update(user, content_type)
        end
      end

      def update(user, content_type)
        @recommendations_object.update_for_user_and_type(user, content_type)
      end

      def destroy(user_id)
        @recommendations_object.destroy(user_id)
      end
    end
  end
end