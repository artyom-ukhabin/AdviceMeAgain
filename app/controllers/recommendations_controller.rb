class RecommendationsController < ApplicationController
  AVAILABLE_TYPES = Content::TYPES + ['personality']

  def index
    current_types = set_types
    @recommendations_data = Shared::RecommendationsDecorator.new.recommendations_data(current_types, current_user)
  end

  private

  def set_types
    type = current_type
    type ? [type] : AVAILABLE_TYPES
  end

  def current_type
    params[:type] if AVAILABLE_TYPES.include?(params[:type])
  end
end
