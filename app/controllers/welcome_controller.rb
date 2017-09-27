class WelcomeController < ApplicationController
  layout "with_recommendations_section"

  def index
    @layout_data = RandomRecommendation::Fetcher.new.get_recommendation(current_user)
  end
end
