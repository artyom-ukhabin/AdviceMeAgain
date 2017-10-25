module ContentBasedFiltering
  module VectorObjects
    class UserPersonalitiesPreference
      #TODO: dependencies
      #TODO: 1) content genres
      #TODO: 2) personalities vectors
      #TODO: 3) personalities rates

      DATASTORE_CONNECTOR_CLASS = DatastoreConnectors::UserPersonalitiesPreferencesConnector
      INITIAL_VECTOR_VALUE = 0

      def initialize
        @datastore_connector = DATASTORE_CONNECTOR_CLASS.new
        @personality_vectors_datastore = VectorObjects::Personality::DATASTORE_CONNECTOR_CLASS.new
      end

      def update(user, content_type)
        user_vector = build_user_vector(user, content_type)
        update_datastore(user, content_type, user_vector)
      end

      def destroy(user_id)
        @datastore_connector.destroy(user_id)
      end

      private

      def build_user_vector(user, content_type)
        raw_vector = raw_user_vector(content_type)
        fill_raw_vector(user, content_type, raw_vector)
      end

      def raw_user_vector(content_type)
        type_genres = "#{content_type.camelize}Genre".constantize.all
        type_genres.inject({}) do |raw_vector, genre|
          raw_vector.merge({ genre.name => INITIAL_VECTOR_VALUE })
        end
      end

      def fill_raw_vector(user, content_type, raw_vector)
        personalities_rates = user.personality_rates
        personalities_rates.each do |rate|
          personality_vector = @personality_vectors_datastore.vector_for(rate.personality_id, content_type)
          raw_vector.each do |genre_name, value|
            raw_vector[genre_name] = accumulate_content_value(value, personality_vector[genre_name], rate)
          end
        end
        raw_vector
      end

      def accumulate_content_value(user_value, personality_value, rate)
        if rate.high?
          user_value + personality_value
        elsif rate.low?
          user_value - personality_value
        end
      end

      def update_datastore(user, content_type, user_vector)
        @datastore_connector.update(user, content_type, user_vector)
      end
    end
  end
end