class PersonalityReview < Base::Review
  belongs_to :personality
  #TODO: provide independency from votable \/
  has_many :votes, class_name: 'PersonalityReviewVote', inverse_of: :personality_review
  has_many :voted_users, through: :votes, source: :user
  has_many :upvoted_users, -> {where("personality_review_votes.vote=?", UPVOTE_CONSTANT)}, through: :votes, source: :user
  has_many :downvoted_users, -> {where("personality_review_votes.vote=?", DOWNVOTE_CONSTANT)}, through: :votes, source: :user

  #TODO: learn about association: vote_value was self for review.scope, not real value
  def users_with_vote(vote_value)
    voted_users.where("personality_review_votes.vote=?", vote_value)
  end
end