require 'rails_helper'

RSpec.describe "personality_reviews/show", type: :view do
  before(:each) do
    @personality_review = assign(:personality_review, PersonalityReview.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
