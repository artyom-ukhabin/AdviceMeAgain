require 'rails_helper'

RSpec.describe "BookGenres", type: :request do
  describe "GET /book_genres" do
    it "works! (now write some real specs)" do
      get book_genres_path
      expect(response).to have_http_status(200)
    end
  end
end
