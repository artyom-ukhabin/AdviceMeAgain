require 'rails_helper'

RSpec.describe "content_reviews/index", type: :view do
  before(:each) do
    assign(:content_reviews, [
      ContentReview.create!(),
      ContentReview.create!()
    ])
  end

  it "renders a list of content_reviews" do
    render
  end
end
