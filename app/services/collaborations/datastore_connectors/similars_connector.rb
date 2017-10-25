module Collaborations
  module DatastoreConnectors
    class SimilarsConnector
      def initialize
        @similarity_model = Elastic::Collaborative::UsersSimilarity
      end

      def for_user_and_type(user, items_type)
        @similarity_model.similarities_for_user_and_type(user.id, items_type)
      end

      def update(items_type, user, other_user, similarity_index)
        model_params = build_similarity_model_params(items_type, user.id, other_user.id, similarity_index)
        @similarity_model.create_or_update(model_params)
      end

      private

      def build_similarity_model_params(items_type, user_id, other_user_id, similarity_index)
        {
          user_id: user_id,
          type: items_type,
          similarity: {
            user_id: other_user_id,
            similarity: similarity_index
          }
        }
      end
    end
  end
end
