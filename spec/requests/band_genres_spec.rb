require 'rails_helper'

RSpec.describe "BandGenres", type: :request do
  describe "GET /band_genres" do
    it "works! (now write some real specs)" do
      get band_genres_path
      expect(response).to have_http_status(200)
    end
  end
end
