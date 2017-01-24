require 'rails_helper'

RSpec.describe "users/index", type: :view do
  let(:first_user) { create(:user) }
  let(:second_user) { create(:user) }

  before(:each) do
    assign(:users, [first_user, second_user])
  end

  it "renders a list of users" do
    render
    assert_select "tr>td", :text => first_user.role
    assert_select "tr>td", :text => second_user.role
  end
end
