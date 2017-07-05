module DecorableWithReviews
  def decorated_reviews(reviewable)
    review_collections = []
    reviewable.reviews.each do |review|
      current_review = {}
      current_review[:review] = review
      current_review[:author_profile] = review.author_profile
      review_collections << current_review
    end
    review_collections
  end

  def build_new_review(reviewable, user)
    reviewable.reviews.build(user_id: user.to_param)
  end
end