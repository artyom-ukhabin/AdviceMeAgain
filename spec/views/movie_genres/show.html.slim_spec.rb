require 'rails_helper'

RSpec.describe "movie_genres/show", type: :view do
  before(:each) do
    @movie_genre = assign(:movie_genre, MovieGenre.create!(
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
  end
end
