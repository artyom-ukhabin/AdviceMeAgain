module ContentBasedFiltering
  module DatastoreConnectors
    class ContentVectorsConnector
      def initialize
        @content_vectors_model = Elastic::ContentBased::ContentVector
      end

      def update(content, content_type, content_vector)
        model_params = build_params_hash(content.id, content_type, content_vector)
        @content_vectors_model.create_or_update(model_params)
      end

      def destroy(content_id)
        @content_vectors_model.delete_by_id(content_id)
      end

      #TODO: type not needed!
      def vector_for(content_id, content_type)
        @content_vectors_model.find_by_type_and_id(content_type, content_id).first
      end

      def vectors_for(content_ids, content_type)
        @content_vectors_model.find_by_type_and_multiply_ids(content_type, content_ids)
      end

      def vectors_for_type(content_type)
        @content_vectors_model.find_by_type(content_type)
      end

      private

      def build_params_hash(content_id, content_type, content_vector)
        {
          content_type: content_type,
          content_id: content_id,
          value: content_vector
        }
      end
    end
  end
end