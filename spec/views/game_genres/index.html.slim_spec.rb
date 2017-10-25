require 'rails_helper'

RSpec.describe "game_genres/index", type: :view do
  before(:each) do
    assign(:game_genres, [
      GameGenre.create!(
        :name => "Name"
      ),
      GameGenre.create!(
        :name => "Name"
      )
    ])
  end

  it "renders a list of game_genres" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
