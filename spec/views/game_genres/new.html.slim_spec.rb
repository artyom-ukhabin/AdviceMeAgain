require 'rails_helper'

RSpec.describe "game_genres/new", type: :view do
  before(:each) do
    assign(:game_genre, GameGenre.new(
      :name => "MyString"
    ))
  end

  it "renders new game_genre form" do
    render

    assert_select "form[action=?][method=?]", game_genres_path, "post" do

      assert_select "input#game_genre_name[name=?]", "game_genre[name]"
    end
  end
end
