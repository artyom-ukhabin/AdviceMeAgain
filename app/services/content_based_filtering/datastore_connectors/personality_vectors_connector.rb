module ContentBasedFiltering
  module DatastoreConnectors
    class PersonalityVectorsConnector
      def initialize
        @personality_vectors_model = Elastic::ContentBased::PersonalityVector
      end

      def update(personality, content_type, personality_vector)
        model_params = build_params_hash(personality.id, content_type, personality_vector)
        @personality_vectors_model.create_or_update(model_params)
      end

      def vector_for(personality_id, content_type)
        @personality_vectors_model.find_by_content_type_and_id(content_type, personality_id).first
      end

      def vectors_for(personality_ids, content_type)
        @personality_vectors_model.find_by_content_type_and_multiply_ids(content_type, personality_ids)
      end

      def vectors_for_type(content_type)
        @personality_vectors_model.find_by_type(content_type)
      end

      def destroy(personality_id)
        @personality_vectors_model.delete_by_id(personality_id)
      end

      private

      def build_params_hash(personality_id, content_type, personality_vector)
        {
          personality_id: personality_id,
          content_type: content_type,
          value: personality_vector
        }
      end
    end
  end
end