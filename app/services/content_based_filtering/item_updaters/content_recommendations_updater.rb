module ContentBasedFiltering
  module ItemUpdaters
    class ContentRecommendationsUpdater
      def initialize
        @recommendations_object = VectorObjects::ContentRecommendations.new
      end

      def update_all_for_type(content_type)
        User.all.each do |user|
          update(user, content_type)
        end
      end

      def update(user, content_type)
        @recommendations_object.update(user, content_type)
      end

      def destroy(user)
        @recommendations_object.destroy(user)
      end
    end
  end
end