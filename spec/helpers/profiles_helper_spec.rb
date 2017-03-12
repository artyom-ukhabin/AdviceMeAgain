require 'rails_helper'

RSpec.describe ProfilesHelper, type: :helper do
  describe '#can_edit_profile?' do
    let(:profile_owner) { create(:user) }
    let(:stranger) { create(:user) }
    let(:admin) { create(:admin) }
    let!(:profile) { profile_owner.create_profile attributes_for(:profile) }

    it { expect(can_edit_profile?(profile_owner, profile)).to be true }
    it { expect(can_edit_profile?(admin, profile)).to be true }
    it { expect(can_edit_profile?(stranger, profile)).to be false }
  end
end