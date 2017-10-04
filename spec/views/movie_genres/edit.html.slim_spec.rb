require 'rails_helper'

RSpec.describe "movie_genres/edit", type: :view do
  before(:each) do
    @movie_genre = assign(:movie_genre, MovieGenre.create!(
      :name => "MyString"
    ))
  end

  it "renders the edit movie_genre form" do
    render

    assert_select "form[action=?][method=?]", movie_genre_path(@movie_genre), "post" do

      assert_select "input#movie_genre_name[name=?]", "movie_genre[name]"
    end
  end
end
