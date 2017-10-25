module ContentBasedFiltering
  module VectorObjects
    class Personality
      #TODO: dependencies
      #TODO: 1) content genres
      #TODO: 2) content vectors
      #TODO: 3) related content

      DATASTORE_CONNECTOR_CLASS = DatastoreConnectors::PersonalityVectorsConnector
      INITIAL_VECTOR_VALUE = 0
      NORMALIZED_NIL = 0.0

      def initialize
        @datastore_connector = DATASTORE_CONNECTOR_CLASS.new
        @content_vectors_datastore = ContentBasedFiltering::VectorObjects::Content::DATASTORE_CONNECTOR_CLASS.new
      end

      def update(personality)
        create_vectors_for_all_types(personality)
      end

      def update_for_content_type(personality, content_type)
        create_single_type_vector(personality, content_type)
      end

      def update_with_several_types(personality, types_for_update)
        create_vectors_for_several_types(personality, types_for_update)
      end

      def destroy_by_id(personality_id)
        @datastore_connector.destroy(personality_id)
      end

      private

      def create_vectors_for_all_types(personality)
        grouped_content = personality.full_grouped_content
        create_vectors_for_grouped_content(personality, grouped_content)
      end

      def create_vectors_for_several_types(personality, content_types)
        grouped_content = personality.full_grouped_content_with_types(content_types)
        create_vectors_for_grouped_content(personality, grouped_content)
      end

      def create_vectors_for_grouped_content(personality, grouped_content)
        grouped_content.each do |content_type, single_type_collection|
          create_vector_for_type(personality, single_type_collection, content_type)
        end
      end

      def create_single_type_vector(personality, content_type)
        related_content = personality.content.with_type(content_type)
        create_vector_for_type(personality, related_content, content_type)
      end

      def create_vector_for_type(personality, content_collection, content_type)
        personality_hash = build_raw_hash(content_type)
        content_collection.each do |content|
          personality_hash = accumulate_content(content, personality_hash)
        end
        personality_vector = normalize_hash(personality_hash)
        update_datastore(personality, content_type, personality_vector)
      end

      def accumulate_content(content, raw_hash)
        content_vector = @content_vectors_datastore.vector_for(content.id, content.type)
        raw_hash.each do |genre_name, _value|
          if content_vector[genre_name] > 0
            raw_hash[genre_name][:value] += content_vector[genre_name]
            raw_hash[genre_name][:count] += 1
          end
        end
      end

      #TODO: its just approximation, learn algorithm
      def normalize_hash(personality_hash)
        personality_hash.each do |genre_name, genre_info|
          personality_hash[genre_name] =
            (genre_info[:count] == 0 ? NORMALIZED_NIL : genre_info[:value].fdiv(genre_info[:count]))
        end
      end

      def build_raw_hash(content_type)
        type_genres = "#{content_type.camelize}Genre".constantize.all
        type_genres.inject({}) do |raw_vector, genre|
          raw_vector.merge({ genre.name => { value: INITIAL_VECTOR_VALUE, count: 0 }})
        end
      end

      def update_datastore(personality, content_type, personality_vector)
        @datastore_connector.update(personality, content_type, personality_vector)
      end
    end
  end
end