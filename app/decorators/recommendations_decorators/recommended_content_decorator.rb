module RecommendationsDecorators
  class RecommendedContentDecorator
    def initialize(items_type)
      @items_type = items_type
      @collaborations_decorator = RecommendationsDecorators::Shared::CollaborationsDecorator.new(@items_type)
      @content_based_decorator = RecommendationsDecorators::Shared::ContentBasedDecorator.new(@items_type)
      @regular_decorator = RecommendationsDecorators::ContentDecorators::RegularDecorator.new(@items_type)
    end

    def recommendations_data(user)
      recommendations_data = {}
      recommendations_data[:type] = @items_type.capitalize.pluralize
      recommendations_data[:collaborations_data] = @collaborations_decorator.recommendations_data(user)
      recommendations_data[:content_based_data] = @content_based_decorator.recommendations_data(user)
      recommendations_data[:other_recommendations] = @regular_decorator.recommendations_data(user)
      recommendations_data
    end
  end
end