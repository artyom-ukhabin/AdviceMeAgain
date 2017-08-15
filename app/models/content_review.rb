class ContentReview < Base::Review
  belongs_to :content
  #TODO: provide independency from votable \/
  has_many :votes, class_name: 'ContentReviewVote', inverse_of: :content_review
  has_many :voted_users, through: :votes, source: :user
  has_many :upvoted_users, -> {where("content_review_votes.vote=?", UPVOTE_CONSTANT)}, through: :votes, source: :user
  has_many :downvoted_users, -> {where("content_review_votes.vote=?", DOWNVOTE_CONSTANT)}, through: :votes, source: :user

  #TODO: learn about association: vote_value was self for review.scope, not real value
  def users_with_vote(vote_value)
    voted_users.where("content_review_votes.vote=?", vote_value)
  end
end