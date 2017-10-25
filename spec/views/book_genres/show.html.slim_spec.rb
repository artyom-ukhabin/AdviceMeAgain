require 'rails_helper'

RSpec.describe "book_genres/show", type: :view do
  before(:each) do
    @book_genre = assign(:book_genre, BookGenre.create!(
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
  end
end
