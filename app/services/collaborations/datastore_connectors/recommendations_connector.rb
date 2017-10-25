module Collaborations
  module DatastoreConnectors
    class RecommendationsConnector
      def initialize
        @recommendation_model = Elastic::Collaborative::ItemPrediction
      end

      def for_user_and_type(user, type)
        @recommendation_model.find_by_user_and_type(user.id, type)
      end

      def update(items_type, user, item, prediction_value)
        model_params = build_recommendation_model_params(items_type, user.id, item.id, prediction_value)
        @recommendation_model.create_or_update(model_params)
      end

      def destroy(user)
        @recommendation_model.delete_by_user(user.id)
      end

      private

      def build_recommendation_model_params(items_type, user_id, item_id, prediction_value)
        {
          user_id: user_id,
          type: items_type,
          prediction: {
            item_id: item_id,
            prediction: prediction_value
          }
        }
      end
    end
  end
end