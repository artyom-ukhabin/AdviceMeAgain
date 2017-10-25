module ContentBasedFiltering
  module Base
    class RecommendationsFetcher
      def recommendations_data
        raise NotImplementedError
      end

      protected

      def build_recommendations_data(raw_vectors, items_type)
        recommended_items = get_recommended_items(raw_vectors, items_type)
        raw_vectors.inject([]) do |recommendations_data, recommendation_vector|
          recommendations_data << build_recommendations_hash(recommended_items, recommendation_vector)
        end
      end

      #TODO: unify with collaboration?
      def type_class_name(type)
        type.classify
      end

      def get_recommended_items(recommendation_vectors, items_type)
        items_ids = get_recommended_items_ids(recommendation_vectors)
        type_class_name(items_type).constantize.find(items_ids)
      end

      def get_recommended_items_ids(recommendation_vectors)
        recommendation_vectors.map do |recommendation_vector|
          recommendation_vector.item_id
        end
      end

      def build_recommendations_hash(recommended_items, recommendation_vector)
        recommendations_hash = {}
        recommendations_hash[:item] = recommended_items.detect{ |item| item.id == recommendation_vector.item_id}
        recommendations_hash[:prediction] = (recommendation_vector.prediction_value * 100).round(2)
        recommendations_hash
      end
    end
  end
end
