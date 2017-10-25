module ContentBasedFiltering
  module DatastoreConnectors
    class ContentRecommendationsConnector
      def initialize
        @recommendations_model = Elastic::ContentBased::ContentPrediction
      end

      def for_user_and_type(user, type)
        @recommendations_model.find_by_user_and_type(user.id, type)
      end

      def update(user_id, content_type, content_id, prediction_value)
        model_params = build_recommendation_model_params(user_id, content_type, content_id, prediction_value)
        @recommendations_model.create_or_update(model_params)
      end

      def destroy_for_user_and_type(user, content_type)
        @recommendations_model.delete_by_user_and_type(user.id, content_type)
      end

      def destroy_for_user(user_id)
        @recommendations_model.delete_by_user(user_id)
      end

      private

      def build_recommendation_model_params(user_id, content_type, content_id, prediction_value)
        {
          user_id: user_id,
          type: content_type,
          prediction: {
            item_id: content_id,
            prediction: prediction_value
          }
        }
      end
    end
  end
end