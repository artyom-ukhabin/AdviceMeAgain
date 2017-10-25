module RandomRecommendation
  class PersonalitiesRecommendationsUnifier
    RECOMMENDATIONS_METHODS = %i(collaborations_data highest_rated most_discussed with_highrated_related_content
      with_liked_related_content content_based_data)
    #TODO: this is abstraction, learn how deal with it
    RECOMMENDATION_TYPES = {
      collaborations: 'collaborations',
      content_based: 'content_based',
      regular: 'regular',
      content_related: 'content_related'
    }

    def initialize
      @collaborations_decorator = RecommendationsDecorators::Shared::CollaborationsDecorator.new(Personality::TYPE)
      @content_based_decorator = RecommendationsDecorators::Shared::ContentBasedDecorator.new(Personality::TYPE)
      @regular_decorator = RecommendationsDecorators::PersonalitiesDecorators::RegularDecorator.new
      @content_related_decorator = RecommendationsDecorators::PersonalitiesDecorators::ContentRelatedDecorator.new
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

    def with_highrated_related_content(_user)
      {
        recommendation_type: RECOMMENDATION_TYPES[:content_related],
        data: @content_related_decorator.with_highrated_related_content
      }
    end


    def with_liked_related_content(user)
      {
        recommendation_type: RECOMMENDATION_TYPES[:content_related],
        data: @content_related_decorator.with_liked_related_content(user)
      }
    end
  end
end