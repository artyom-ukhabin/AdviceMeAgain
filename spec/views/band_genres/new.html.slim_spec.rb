require 'rails_helper'

RSpec.describe "band_genres/new", type: :view do
  before(:each) do
    assign(:band_genre, BandGenre.new(
      :name => "MyString"
    ))
  end

  it "renders new band_genre form" do
    render

    assert_select "form[action=?][method=?]", band_genres_path, "post" do

      assert_select "input#band_genre_name[name=?]", "band_genre[name]"
    end
  end
end
