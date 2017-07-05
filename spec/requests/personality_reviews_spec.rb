require 'rails_helper'

RSpec.describe "PersonalityReviews", type: :request do
  describe "GET /personality_reviews" do
    it "works! (now write some real specs)" do
      get personality_reviews_path
      expect(response).to have_http_status(200)
    end
  end
end
