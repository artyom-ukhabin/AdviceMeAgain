require 'rails_helper'

RSpec.describe UsersHelper, type: :helper do
  describe '#actual_profile_path' do
    let(:user_without_profile) { User.create } # TODO: Factory implementation
    let(:user_with_profile) { } #TODO: Factory implementation
    let(:new_path) { new_user_profile_path(user_without_profile) }
    let(:edit_path) { edit_user_profile_path(user_with_profile) }

    it 'should generate new profile link for user without profile' do
      expect(helper.actual_profile_path(user_without_profile)). to eq new_path
    end

    it 'should generate edit profile link for user with profile' do
      skip("waiting for factory implementation of user")
      expect(helper.actual_profile_path(user_with_profile)).to eq edit_path
    end
  end
end