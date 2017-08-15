module VotesControllerMethods
  def set_voted_users_info(voteable, vote)
    users_names = voteable.users_names_with_vote(vote)
    return users_names unless users_names.blank?
    'No votes yet'
  end
end