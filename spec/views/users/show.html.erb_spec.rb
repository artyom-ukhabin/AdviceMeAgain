require 'rails_helper'

RSpec.describe "users/show", type: :view do
  before(:each) do
    @user = assign(:user, User.create!(
      :role => "Role"
    )) #TODO: factory implementation
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Role/)
  end
end
