require 'rails_helper'

RSpec.describe "personalities/index", type: :view do
  before(:each) do
    assign(:personalities, [
      Personality.create!(
        :name => "Name",
        :info => "MyText"
      ),
      Personality.create!(
        :name => "Name",
        :info => "MyText"
      )
    ])
  end

  it "renders a list of personalities" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
