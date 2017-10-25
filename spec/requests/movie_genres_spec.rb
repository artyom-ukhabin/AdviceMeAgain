require 'rails_helper'

RSpec.describe "MovieGenres", type: :request do
  describe "GET /movie_genres" do
    it "works! (now write some real specs)" do
      get movie_genres_path
      expect(response).to have_http_status(200)
    end
  end
end
