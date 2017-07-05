require 'rails_helper'

RSpec.describe "personality_reviews/edit", type: :view do
  before(:each) do
    @personality_review = assign(:personality_review, PersonalityReview.create!())
  end

  it "renders the edit personality_review form" do
    render

    assert_select "form[action=?][method=?]", personality_review_path(@personality_review), "post" do
    end
  end
end
