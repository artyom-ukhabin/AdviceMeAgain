require 'rails_helper'

RSpec.describe UsersHelper, type: :helper do
  describe '#actual_profile_path' do
    let(:user_without_profile) { create(:user) }
    let(:user_with_profile) { create(:user_with_profile) }
    let(:new_path) { new_profile_path }
    let(:show_path) { profile_path(user_with_profile.profile) }

    it 'should generate new profile link for user without profile' do
      expect(helper.actual_profile_path(user_without_profile)). to eq new_path
    end

    it 'should generate show profile link for user with profile' do
      expect(helper.actual_profile_path(user_with_profile)).to eq show_path
    end
  end
end