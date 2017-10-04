require 'rails_helper'

RSpec.describe "band_genres/edit", type: :view do
  before(:each) do
    @band_genre = assign(:band_genre, BandGenre.create!(
      :name => "MyString"
    ))
  end

  it "renders the edit band_genre form" do
    render

    assert_select "form[action=?][method=?]", band_genre_path(@band_genre), "post" do

      assert_select "input#band_genre_name[name=?]", "band_genre[name]"
    end
  end
end
