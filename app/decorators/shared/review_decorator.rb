module Shared
  class ReviewDecorator
    include DecorableWithVotes #TODO: refactor

    def decorate(review, current_user)
      decorated_review = {}
      decorated_review[:review] = review
      decorated_review[:author_profile] = review.author_profile
      decorated_review[:votes_data] = votes_data(review, current_user)
      decorated_review
    end
  end
end