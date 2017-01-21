require 'rails_helper'

RSpec.describe "profiles/edit", type: :view do
  let(:profile_owner) { User.create }

  before(:each) do
    @profile = assign(:profile, profile_owner.create_profile(
      :name => "MyString",
      :city => "MyString",
      :info => "MyString"
    )) #TODO: factory implementation
    @user = assign(:user, profile_owner)
  end

  it "renders the edit profile form" do
    controller.request.path_parameters[:user_id] = profile_owner.to_param #TODO: investigate
    render

    assert_select "form[action=?][method=?]", user_profile_path(profile_owner), "post" do

      assert_select "input#profile_name[name=?]", "profile[name]"

      assert_select "input#profile_city[name=?]", "profile[city]"

      assert_select "input#profile_info[name=?]", "profile[info]"
    end
  end
end
