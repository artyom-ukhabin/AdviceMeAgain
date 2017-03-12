require 'rails_helper'

RSpec.describe "Active admin access", type: :request do
  describe "GET /admin" do
    let(:user) { create :user }
    let(:admin) { create :admin }

    it "should redirect to sign_in page if user dont sign in" do
      get admin_root_path
      expect(response).to redirect_to(new_user_session_path)
    end

    it "should redirect to root if user signed as non-admin" do
      sign_in user
      get admin_root_path
      expect(response).to redirect_to(root_path)
    end

    it "should allow access if user signed as admin" do
      sign_in admin
      get admin_root_path
      expect(response).to_not be_redirect
      expect(response).to have_http_status(:success)
    end
  end
end
