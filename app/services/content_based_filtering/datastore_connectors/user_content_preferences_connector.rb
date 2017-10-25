module ContentBasedFiltering
  module DatastoreConnectors
    class UserContentPreferencesConnector
      def initialize
        @user_vectors_model = Elastic::ContentBased::UserContentPreferenceVector
      end

      def update(user, content_type, user_vector)
        model_params = build_params_hash(user.id, content_type, user_vector)
        @user_vectors_model.create_or_update(model_params)
      end

      def vector_for(user_id, content_type)
        @user_vectors_model.find_by_type_and_id(content_type, user_id).first
      end

      def destroy(user_id)
        @user_vectors_model.delete_by_id(user_id)
      end

      private

      def build_params_hash(user_id, content_type, user_vector)
        {
          content_type: content_type,
          user_id: user_id,
          value: user_vector
        }
      end
    end
  end
end