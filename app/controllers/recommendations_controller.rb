class RecommendationsController < ApplicationController
  #TODO: think about model level
  PERSONALITY_TYPE = Personality::TYPE
  AVAILABLE_TYPES = Content::TYPES + [PERSONALITY_TYPE]

  def index
    current_types = set_recommendations_types
    @recommendations_data = index_data(current_types)
  end

  private

  def index_data(current_types)
    recommendations_decorator = RecommendationsDecorator.new(current_types)
    recommendations_decorator.recommendations_data(current_user)
  end

  def set_recommendations_types
    type = current_type
    type ? [type] : AVAILABLE_TYPES
  end

  def current_type
    params[:type] if AVAILABLE_TYPES.include?(params[:type])
  end
end
