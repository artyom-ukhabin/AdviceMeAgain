module ContentBasedFiltering
  module VectorObjects
    class Content
      DATASTORE_CONNECTOR_CLASS = DatastoreConnectors::ContentVectorsConnector

      ABSENT_VALUE = 0
      PRESENT_VALUE = 1

      def initialize
        @datastore_connector = DATASTORE_CONNECTOR_CLASS.new
      end

      def update(content)
        content_type = content.type
        content_vector = build_content_vector(content, content_type)
        update_datastore(content, content_type, content_vector)
      end

      def destroy_by_id(content_id)
        @datastore_connector.destroy(content_id)
      end

      private

      def build_content_vector(content, content_type)
        genre_ids = content.genre_ids
        raw_vector = raw_content_vector(content_type, genre_ids)
        normalize_raw_vector(raw_vector, genre_ids)
      end

      def raw_content_vector(content_type, genre_ids)
        all_genres_for_type = "#{content_type}Genre".constantize.all
        all_genres_for_type.inject({}) do |raw_vector, genre|
          raw_vector[genre.name] = genre_ids.include?(genre.id) ? PRESENT_VALUE : ABSENT_VALUE
          raw_vector
        end
      end

      def normalize_raw_vector(raw_vector, genre_ids)
        return raw_vector unless genre_ids.present?
        raw_vector.each do |genre_name, value|
          raw_vector[genre_name] = value.fdiv(Math.sqrt(genre_ids.length))
        end
      end

      def update_datastore(content, content_type, content_vector)
        @datastore_connector.update(content, content_type, content_vector)
      end
    end
  end
end