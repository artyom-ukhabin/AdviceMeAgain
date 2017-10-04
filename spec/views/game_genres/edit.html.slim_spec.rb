require 'rails_helper'

RSpec.describe "game_genres/edit", type: :view do
  before(:each) do
    @game_genre = assign(:game_genre, GameGenre.create!(
      :name => "MyString"
    ))
  end

  it "renders the edit game_genre form" do
    render

    assert_select "form[action=?][method=?]", game_genre_path(@game_genre), "post" do

      assert_select "input#game_genre_name[name=?]", "game_genre[name]"
    end
  end
end
