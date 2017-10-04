require 'rails_helper'

RSpec.describe "movie_genres/index", type: :view do
  before(:each) do
    assign(:movie_genres, [
      MovieGenre.create!(
        :name => "Name"
      ),
      MovieGenre.create!(
        :name => "Name"
      )
    ])
  end

  it "renders a list of movie_genres" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
