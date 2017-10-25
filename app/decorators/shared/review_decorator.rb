module Shared
  class ReviewDecorator
    def initialize
      @vote_decorator = VoteDecorator.new
    end

    def decorate(review, current_user)
      decorated_review = {}
      decorated_review[:review] = review
      decorated_review[:author_profile] = review.author_profile
      decorated_review[:votes_data] = @vote_decorator.votes_data(review, current_user)
      decorated_review
    end
  end
end