module RecommendationsDecorators
  class RecommendedPersonalitiesDecorator
    PERSONALITY_TYPE = Personality::TYPE

    #TODO: still think about better interface
    def initialize
      @collaborations_decorator =
        RecommendationsDecorators::Shared::CollaborationsDecorator.new(PERSONALITY_TYPE)
      @regular_decorator = RecommendationsDecorators::PersonalitiesDecorators::RegularDecorator.new
      @content_related_decorator = RecommendationsDecorators::PersonalitiesDecorators::ContentRelatedDecorator.new
    end

    def recommendations_data(user)
      recommendations_data = {}
      recommendations_data[:collaborations_data] = @collaborations_decorator.recommendations_data(user)
      recommendations_data[:regular_recommendations] = @regular_decorator.recommendations_data
      recommendations_data[:content_related_recommendations] =  @content_related_decorator.recommendations_data(user)
      recommendations_data
    end
  end
end