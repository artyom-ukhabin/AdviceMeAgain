require 'rails_helper'

RSpec.describe "content_reviews/edit", type: :view do
  before(:each) do
    @content_review = assign(:content_review, ContentReview.create!())
  end

  it "renders the edit content_review form" do
    render

    assert_select "form[action=?][method=?]", content_review_path(@content_review), "post" do
    end
  end
end
