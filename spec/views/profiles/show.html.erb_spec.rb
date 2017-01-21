require 'rails_helper'

RSpec.describe "profiles/show", type: :view do
  let(:profile_owner) { User.create }

  before(:each) do
    @profile = assign(:profile, profile_owner.create_profile(
      :name => "Name",
      :city => "City",
      :info => "Info"
    )) #TODO: factory implementation
    @user = assign(:user, profile_owner)
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/City/)
    expect(rendered).to match(/Info/)
  end
end
