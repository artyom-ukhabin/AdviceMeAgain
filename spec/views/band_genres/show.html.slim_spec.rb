require 'rails_helper'

RSpec.describe "band_genres/show", type: :view do
  before(:each) do
    @band_genre = assign(:band_genre, BandGenre.create!(
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
  end
end
