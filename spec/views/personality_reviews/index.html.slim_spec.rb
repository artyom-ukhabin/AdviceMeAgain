require 'rails_helper'

RSpec.describe "personality_reviews/index", type: :view do
  before(:each) do
    assign(:personality_reviews, [
      PersonalityReview.create!(),
      PersonalityReview.create!()
    ])
  end

  it "renders a list of personality_reviews" do
    render
  end
end
