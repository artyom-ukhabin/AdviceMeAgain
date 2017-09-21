module DecorableWithReviews
  REVIEW_DECORATOR = Shared::ReviewDecorator.new #TODO: refactor - constructor and @variable

  def decorated_reviews(reviewable, current_user)
    reviewable.reviews.inject([]) do |review_data, review|
      current_review = decorate_review(review, current_user)
      review_data << current_review
    end
  end

  def build_new_review(reviewable, user)
    reviewable.reviews.build(user_id: user.to_param)
  end

  private

  #TODO: refactor, exchange modules to classes with constructors

  def decorate_review(review, current_user)
    REVIEW_DECORATOR.decorate(review, current_user)
  end
end