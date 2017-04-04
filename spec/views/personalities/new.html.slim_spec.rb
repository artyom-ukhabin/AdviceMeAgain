require 'rails_helper'

RSpec.describe "personalities/new", type: :view do
  before(:each) do
    assign(:personality, Personality.new(
      :name => "MyString",
      :info => "MyText"
    ))
  end

  it "renders new personality form" do
    render

    assert_select "form[action=?][method=?]", personalities_path, "post" do

      assert_select "input#personality_name[name=?]", "personality[name]"

      assert_select "textarea#personality_info[name=?]", "personality[info]"
    end
  end
end
