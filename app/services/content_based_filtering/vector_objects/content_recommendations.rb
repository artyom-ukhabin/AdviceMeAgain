module ContentBasedFiltering
  module VectorObjects
    class ContentRecommendations
      #TODO: dependencies
      #TODO: 1) content vectors
      #TODO: 2) user_content_preferences vectors

      INITIAL_DOCUMENT_HASH_VALUE = 0

      def initialize
        @content_vectors_connector = VectorObjects::Content::DATASTORE_CONNECTOR_CLASS.new
        @user_vectors_connector = VectorObjects::UserContentPreference::DATASTORE_CONNECTOR_CLASS.new
        @recommendations_connector = DatastoreConnectors::ContentRecommendationsConnector.new
      end

      def for_user_and_type(user, content_type)
        recommendations = @recommendations_connector.for_user_and_type(user, content_type)
        fetch_positive_recommendations(recommendations)
      end

      def update(user, content_type)
        clean_recommendations_for(user, content_type)
        user_vector = @user_vectors_connector.vector_for(user.id, content_type)
        unrated_content_ids = current_model(content_type).ids - user.ids_for_rated_content(content_type)
        unrated_content_vectors = @content_vectors_connector.vectors_for(unrated_content_ids, content_type)
        update_predictions(user_vector, unrated_content_vectors, content_type)
      end

      def destroy(user_id)
        @recommendations_connector.destroy_for_user(user_id)
      end

      private

      def clean_recommendations_for(user, content_type)
        @recommendations_connector.destroy_for_user_and_type(user, content_type)
      end

      def current_model(content_type)
        "#{content_type.camelize}".constantize
      end

      #TODO: Content Based Recommendation Engine
      #TODO: https://www.analyticsvidhya.com/blog/2015/08/beginners-guide-learn-content-based-recommender-systems/
      def update_predictions(user_vector, unrated_content_vectors, content_type)
        inversed_document_frequency_hash = build_inversed_document_frequency_hash(content_type)
        unrated_content_vectors.each do |content_vector|
          set_single_prediction(user_vector, content_vector, inversed_document_frequency_hash, content_type)
        end
      end

      def set_single_prediction(user_vector, content_vector, inversed_document_frequency_hash, content_type)
        prediction_value = calculate_prediction(content_vector, user_vector, inversed_document_frequency_hash)
        save_prediction(user_vector.user_id, content_type, content_vector.item_id, prediction_value)
      end

      def build_inversed_document_frequency_hash(content_type)
        all_content_vectors = @content_vectors_connector.vectors_for_type(content_type)
        document_frequency_hash = build_document_frequency_hash(all_content_vectors)
        document_frequency_hash.inject(Hash.new(0)) do |inversed_document_frequency_hash, (key, value)|
          inversed_document_frequency_hash.merge key => Math.log10(all_content_vectors.length.fdiv(value))
        end
      end

      def build_document_frequency_hash(all_content_vectors)
        all_content_vectors.inject(Hash.new(0)) do |document_frequency_hash, content_vector|
          content_vector.value.each do |genre_name, value|
            document_frequency_hash[genre_name] += 1 if value != 0
          end
          document_frequency_hash
        end
      end

      #INFO: all hashes have to be genre.all.count-sized
      def calculate_prediction(content_vector, user_vector, inversed_document_frequency_hash)
        content_vector.value.inject(0) do |prediction_value, (content_genre, _value)|
          prediction_value +
            content_vector[content_genre] *
            user_vector[content_genre] *
            inversed_document_frequency_hash[content_genre]
        end
      end

      def save_prediction(user_id, content_type, content_id, prediction_value)
        @recommendations_connector.update(user_id, content_type, content_id, prediction_value)
      end

      def fetch_positive_recommendations(recommendations)
        recommendations.select do |recommendation|
          recommendation.prediction_value > 0
        end
      end
    end
  end
end