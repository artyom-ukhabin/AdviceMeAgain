module ContentBasedFiltering
  class ContentRecommendationsFetcher < ContentBasedFiltering::Base::RecommendationsFetcher
    def initialize
      @recommendations_vectors_object = VectorObjects::ContentRecommendations.new
    end

    def recommendations_data(user, content_type)
      raw_vectors = @recommendations_vectors_object.for_user_and_type(user, content_type)
      build_recommendations_data(raw_vectors, content_type)
    end
  end
end