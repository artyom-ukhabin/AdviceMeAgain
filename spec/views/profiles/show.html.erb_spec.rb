require 'rails_helper'

RSpec.describe "profiles/show", type: :view do #TODO: think about stub problem later
  let(:profile_owner) { create(:user) }
  let(:profile) { create(:profile, user: profile_owner) }

  before(:each) do
    @profile = assign(:profile, profile)
    @user = assign(:user, profile_owner)
    # allow(view).to receive(:can_edit_profile?).and_return(true)
  end

  it "should render attributes in <p>" do
    skip('stubbing helper_method problem, think about me later')

    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/City/)
    expect(rendered).to match(/Info/)
  end
end
