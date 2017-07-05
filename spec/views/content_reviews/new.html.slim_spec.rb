require 'rails_helper'

RSpec.describe "content_reviews/new", type: :view do
  before(:each) do
    assign(:content_review, ContentReview.new())
  end

  it "renders new content_review form" do
    render

    assert_select "form[action=?][method=?]", content_reviews_path, "post" do
    end
  end
end
