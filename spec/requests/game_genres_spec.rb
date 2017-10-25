require 'rails_helper'

RSpec.describe "GameGenres", type: :request do
  describe "GET /game_genres" do
    it "works! (now write some real specs)" do
      get game_genres_path
      expect(response).to have_http_status(200)
    end
  end
end
