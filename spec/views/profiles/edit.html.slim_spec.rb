require 'rails_helper'

RSpec.describe "profiles/edit", type: :view do
  let(:profile_owner) { create(:user) }
  let(:profile) { create(:profile, user: profile_owner) }

  before(:each) do
    @profile = assign(:profile, profile)
    @user = assign(:user, profile_owner)
  end

  it "renders the edit profile form" do
    controller.request.path_parameters[:user_id] = profile_owner.to_param #TODO: investigate
    render

    assert_select "form[action=?][method=?]", profile_path(profile), "post" do

      assert_select "input#profile_name[name=?]", "profile[name]"

      assert_select "input#profile_city[name=?]", "profile[city]"

      assert_select "input#profile_info[name=?]", "profile[info]"
    end
  end
end
