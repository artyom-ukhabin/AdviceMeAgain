class RecommendationsController < ApplicationController
  #TODO: think about model level
  PERSONALITY_TYPE = Personality.name.downcase
  AVAILABLE_TYPES = Content::TYPES + [PERSONALITY_TYPE]

  def index
    current_types = set_recommendations_types
    @recommendations_data = index_data(current_types)
  end

  private

  def index_data(current_types)
    content_types = filter_content_types(current_types)
    personality_presence = check_personality_type(current_types)
    recommendations_decorator = RecommendationsDecorator.new(content_types, personality_presence)
    recommendations_decorator.recommendations_data(current_user)
  end

  def filter_content_types(recommendations_types)
    Content.filter_content_types(recommendations_types)
  end

  #TODO: think about model level for personality like for content
  def check_personality_type(recommendations_types)
    recommendations_types.include? PERSONALITY_TYPE
  end

  def set_recommendations_types
    type = current_type
    type ? [type] : AVAILABLE_TYPES
  end

  def current_type
    params[:type] if AVAILABLE_TYPES.include?(params[:type])
  end
end
