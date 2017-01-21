require 'rails_helper'

RSpec.describe "users/index", type: :view do
  before(:each) do
    assign(:users, [
      User.create!(
        :role => "Role"
      ),
      User.create!(
        :role => "Role"
      )
    ]) #TODO: factory implementation
  end

  it "renders a list of users" do
    render
    assert_select "tr>td", :text => "Role".to_s, :count => 2
  end
end
