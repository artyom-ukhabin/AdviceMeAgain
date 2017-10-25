require 'rails_helper'

RSpec.describe "book_genres/new", type: :view do
  before(:each) do
    assign(:book_genre, BookGenre.new(
      :name => "MyString"
    ))
  end

  it "renders new book_genre form" do
    render

    assert_select "form[action=?][method=?]", book_genres_path, "post" do

      assert_select "input#book_genre_name[name=?]", "book_genre[name]"
    end
  end
end
