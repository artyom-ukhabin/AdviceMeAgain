require 'rails_helper'

RSpec.describe "book_genres/index", type: :view do
  before(:each) do
    assign(:book_genres, [
      BookGenre.create!(
        :name => "Name"
      ),
      BookGenre.create!(
        :name => "Name"
      )
    ])
  end

  it "renders a list of book_genres" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
