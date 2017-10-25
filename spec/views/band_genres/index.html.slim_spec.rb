require 'rails_helper'

RSpec.describe "band_genres/index", type: :view do
  before(:each) do
    assign(:band_genres, [
      BandGenre.create!(
        :name => "Name"
      ),
      BandGenre.create!(
        :name => "Name"
      )
    ])
  end

  it "renders a list of band_genres" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
