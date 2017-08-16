class RecommendationsController < ApplicationController
  def index
    @recomendations_data = RecommendationsDecorator.new.recommendations_data
  end
end
