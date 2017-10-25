module RandomRecommendation
  class ContentRecommendationsUnifier
    RECOMMENDATIONS_METHODS = %i(collaborations_data highest_rated most_discussed most_mentioned
      with_highrated_related_personalities with_liked_related_personalities content_based_data)
    #TODO: this is abstraction, learn how deal with it
    RECOMMENDATION_TYPES = {
      collaborations: 'collaborations',
      content_based: 'content_based',
      regular: 'regular'
    }

    def initialize(items_type)
      @items_type = items_type
      @collaborations_decorator = RecommendationsDecorators::Shared::CollaborationsDecorator.new(@items_type)
      @content_based_decorator = RecommendationsDecorators::Shared::ContentBasedDecorator.new(@items_type)
      @regular_decorator = RecommendationsDecorators::ContentDecorators::RegularDecorator.new(@items_type)
    end

    def content_based_data(user)
      {
        recommendation_type: RECOMMENDATION_TYPES[:content_based],
        data: @content_based_decorator.recommendations_data(user)
      }
    end

    def collaborations_data(user)
      {
        recommendation_type: RECOMMENDATION_TYPES[:collaborations],
        data: @collaborations_decorator.recommendations_data(user)
      }
    end

    def highest_rated(_user)
      {
        recommendation_type: RECOMMENDATION_TYPES[:regular],
        data: @regular_decorator.highest_rated
      }
    end

    def most_discussed(_user)
      {
        recommendation_type: RECOMMENDATION_TYPES[:regular],
        data: @regular_decorator.most_discussed
      }
    end

    def most_mentioned(_user)
      {
        recommendation_type: RECOMMENDATION_TYPES[:regular],
        data: @regular_decorator.most_mentioned
      }
    end

    def with_highrated_related_personalities(_user)
      {
        recommendation_type: RECOMMENDATION_TYPES[:regular],
        data: @regular_decorator.with_highrated_related_personalities
      }
    end

    def with_liked_related_personalities(user)
      {
        recommendation_type: RECOMMENDATION_TYPES[:regular],
        data: @regular_decorator.with_liked_related_personalities(user)
      }
    end
  end
end