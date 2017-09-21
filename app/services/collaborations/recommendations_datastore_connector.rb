module Collaborations
  class RecommendationsDatastoreConnector

    def initialize
      @recommendation_model = Elastic::UserItemPrediction
    end

    def for_user_and_type(user, type)
      @recommendation_model.find_by_user_and_type(user.id, type)
    end

    def update(items_type, user, item, prediction_value)
      model_params = build_recommendation_model_params(items_type, user.id, item.id, prediction_value)
      @recommendation_model.create_or_update(model_params)
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