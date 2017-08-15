require 'rails_helper'

RSpec.describe "content_reviews/show", type: :view do
  before(:each) do
    @content_review = assign(:content_review, ContentReview.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
