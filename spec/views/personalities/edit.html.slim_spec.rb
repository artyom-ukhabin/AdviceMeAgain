require 'rails_helper'

RSpec.describe "personalities/edit", type: :view do
  before(:each) do
    @personality = assign(:personality, Personality.create!(
      :name => "MyString",
      :info => "MyText"
    ))
  end

  it "renders the edit personality form" do
    render

    assert_select "form[action=?][method=?]", personality_path(@personality), "post" do

      assert_select "input#personality_name[name=?]", "personality[name]"

      assert_select "textarea#personality_info[name=?]", "personality[info]"
    end
  end
end
