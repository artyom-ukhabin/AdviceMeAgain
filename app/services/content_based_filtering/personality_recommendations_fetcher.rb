module ContentBasedFiltering
  class PersonalityRecommendationsFetcher < ContentBasedFiltering::Base::RecommendationsFetcher
    def initialize
      @recommendations_vectors_object = VectorObjects::PersonalityRecommendations.new
    end

    def recommendations_data(user, _items_type)
      user.personalities_content_types.inject([]) do |recommendations_data, content_type|
        raw_vectors = @recommendations_vectors_object.for_user_and_type(user, content_type)
        recommendations = build_recommendations_data(raw_vectors, Personality::TYPE)
        recommendations_data << build_single_type_hash(content_type, recommendations)
      end
    end

    def build_single_type_hash(content_type, recommendations)
      single_type_hash = {}
      single_type_hash[:type] = content_type
      single_type_hash[:items] = recommendations
      single_type_hash
    end
  end
end
