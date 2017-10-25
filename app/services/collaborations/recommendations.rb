module Collaborations
  class Recommendations
    def initialize(items_type, rater, similars)
      @items_type = items_type
      @recommendations_datastore_connector = Collaborations::DatastoreConnectors::RecommendationsConnector.new
      @rater = rater
      @similars = similars
    end

    def for_user(user)
      recommendations = @recommendations_datastore_connector.for_user_and_type(user, @items_type)
      fetch_positive_recommendations(recommendations)
    end

    def update(user)
      clean_recommendations(user)
      similarities = @similars.similars_for(user)
      unrated_items_from_similar = unrated_items_from_similar(user, similarities)
      update_predictions(user, similarities, unrated_items_from_similar)
    end

    private

    def clean_recommendations(user)
      @recommendations_datastore_connector.destroy(user)
    end

    def fetch_positive_recommendations(recommendations)
      recommendations.select do |recommendation|
        recommendation.prediction_value > 0
      end
    end

    def unrated_items_from_similar(user, similarities)
      rated_items = @rater.find_items([user])
      others_rated_items = rated_by_similars(similarities)
      others_rated_items - rated_items
    end

    def rated_by_similars(similarities)
      similar_users_ids = similarities.map(&:user_id)
      @rater.find_items(similar_users_ids)
    end

    def update_predictions(user, similarities, unrated_items)
      unrated_items.each do |item|
        set_single_prediction(user, item, similarities)
      end
    end

    def set_single_prediction(user, item, similarities)
      rated_users = @rater.find_users([item])
      summary_index = item_similarity_index(rated_users, similarities)
      prediction_value = summary_index / rated_users.length
      save_prediction(user, item, prediction_value)
    end

    def item_similarity_index(rated_users, similarities)
      summary_index = 0
      rated_users.each do |rated_user|
        similar = similarities.detect { |similarity| similarity.user_id == rated_user.id }
        summary_index += similar.similarity if similar
      end
      summary_index
    end

    def save_prediction(user, item, prediction_value)
      @recommendations_datastore_connector.update(@items_type, user, item, prediction_value)
    end
  end
end