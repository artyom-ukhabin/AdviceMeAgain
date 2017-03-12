require 'rails_helper'

RSpec.describe "profiles/show", type: :view do #TODO: think about stub problem later
  let(:profile_owner) { create(:user) }
  let(:stranger) { create(:user) }
  let(:profile) { create(:profile, user: profile_owner) }

  before(:each) do
    @profile = assign(:profile, profile)
    @user = assign(:user, profile_owner)
    allow(view).to receive(:current_user).and_return(profile_owner)
  end

  it "should render attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/City/)
    expect(rendered).to match(/Info/)
  end

  it 'should render edit link for user with permissions' do
    render
    expect(rendered).to match(/Edit/)
  end

  it 'should not render edit link for user without permissions' do
    allow(view).to receive(:current_user).and_return(stranger)
    render
    expect(rendered).to_not match(/Edit/)
  end
end
