module DecorableWithVotes
  def votes_data(voteable, user)
    votes_data = {}
    votes_data[:upvoted_users_count] = voteable.upvoted_users_count
    votes_data[:downvoted_users_count] = voteable.downvoted_users_count
    votes_data[:already_upvoted] = voteable.already_upvoted_by?(user)
    votes_data[:already_downvoted] = voteable.already_downvoted_by?(user)
    votes_data[:vote] = voteable.vote_for(user) if voteable.already_voted_by?(user)
    votes_data
  end
end