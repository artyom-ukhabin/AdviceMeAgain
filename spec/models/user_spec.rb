require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Setting role' do
    it 'should set default role' do
      expect(create(:user_without_role).regular?).to eq true
    end

    it 'should change blank role with regular' do
      user = create(:regular_user)
      user.update_attributes(role: '')
      expect(user.regular?).to eq true
    end
  end
end
