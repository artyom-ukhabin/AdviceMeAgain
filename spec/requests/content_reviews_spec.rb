require 'rails_helper'

RSpec.describe "ContentReviews", type: :request do
  describe "GET /content_reviews" do
    it "works! (now write some real specs)" do
      get content_reviews_path
      expect(response).to have_http_status(200)
    end
  end
end
