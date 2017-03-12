require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do
  let(:user) { create :user }

  describe "GET #index" do
    it "returns http success" do
      sign_in user
      get :index
      expect(response).to have_http_status(:success)
    end
  end
end