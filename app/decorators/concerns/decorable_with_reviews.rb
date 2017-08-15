module DecorableWithReviews
  include DecorableWithVotes

  def decorated_reviews(reviewable, current_user)
    review_data = []
    reviewable.reviews.each do |review|
      current_review = decorate_review(review)
      current_review[:votes_data] = votes_data(review, current_user)
      review_data << current_review
    end
    review_data
  end

  def build_new_review(reviewable, user)
    reviewable.reviews.build(user_id: user.to_param)
  end

  private

  def decorate_review(review)
    decorated_review = {}
    decorated_review[:review] = review
    decorated_review[:author_profile] = review.author_profile
    decorated_review
  end
end