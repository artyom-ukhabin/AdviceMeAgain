class RecommendationsDecorator
  def initialize(content_types, include_personality)
    @content_types = content_types
    @include_personality = include_personality
    @content_decorator_class = RecommendationsDecorators::RecommendedContentDecorator
    @personality_decorator_class = RecommendationsDecorators::RecommendedPersonalitiesDecorator
  end

  def recommendations_data(user)
    recommendations_data = {}
    recommendations_data[:content_data] = set_content_data(user) if @content_types.present?
    recommendations_data[:personalities_data] = set_personalities_data(user) if @include_personality
    recommendations_data
  end

  private

  def set_content_data(user)
    @content_types.inject([]) do |content_data, type|
      content_decorator = @content_decorator_class.new(type)
      content_data << content_decorator.recommendations_data(user)
    end
  end

  def set_personalities_data(user)
    personality_decorator = @personality_decorator_class.new
    personality_decorator.recommendations_data(user)
  end
end