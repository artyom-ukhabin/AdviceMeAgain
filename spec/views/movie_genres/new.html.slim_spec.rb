require 'rails_helper'

RSpec.describe "movie_genres/new", type: :view do
  before(:each) do
    assign(:movie_genre, MovieGenre.new(
      :name => "MyString"
    ))
  end

  it "renders new movie_genre form" do
    render

    assert_select "form[action=?][method=?]", movie_genres_path, "post" do

      assert_select "input#movie_genre_name[name=?]", "movie_genre[name]"
    end
  end
end
