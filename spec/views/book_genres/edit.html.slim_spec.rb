require 'rails_helper'

RSpec.describe "book_genres/edit", type: :view do
  before(:each) do
    @book_genre = assign(:book_genre, BookGenre.create!(
      :name => "MyString"
    ))
  end

  it "renders the edit book_genre form" do
    render

    assert_select "form[action=?][method=?]", book_genre_path(@book_genre), "post" do

      assert_select "input#book_genre_name[name=?]", "book_genre[name]"
    end
  end
end
