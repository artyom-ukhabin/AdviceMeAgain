require 'rails_helper'

RSpec.describe "profiles/show", type: :view do
  let(:profile_owner) { create(:user) }
  let(:profile) { create(:profile, user: profile_owner) }

  before(:each) do
    @profile = assign(:profile, profile)
    @user = assign(:user, profile_owner)
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/City/)
    expect(rendered).to match(/Info/)
  end
end
