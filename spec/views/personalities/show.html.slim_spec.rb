require 'rails_helper'

RSpec.describe "personalities/show", type: :view do
  before(:each) do
    @personality = assign(:personality, Personality.create!(
      :name => "Name",
      :info => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
  end
end
