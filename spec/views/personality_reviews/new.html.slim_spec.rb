require 'rails_helper'

RSpec.describe "personality_reviews/new", type: :view do
  before(:each) do
    assign(:personality_review, PersonalityReview.new())
  end

  it "renders new personality_review form" do
    render

    assert_select "form[action=?][method=?]", personality_reviews_path, "post" do
    end
  end
end
