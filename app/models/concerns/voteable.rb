module Voteable
  UPVOTE_CONSTANT = 1
  DOWNVOTE_CONSTANT = -1

  #TODO: refactor
  #TODO: URGENT: get rid of dependecies with classes where module includes - use parameters
  #TODO: direct call on model instead of inderect calls from this module
  #TODO: pass join table name instead of associations maybe

  #set methods

  def set_vote(user, vote_value)
    return false unless vote_value_allowed?(vote_value.to_i)
    votes.create("#{voteable_class_name.underscore}_id": self.id, user_id: user.id, vote: vote_value)
  end

  def update_vote(vote, new_value)
    return false unless vote_value_allowed?(new_value.to_i)
    vote.update_attribute(:vote, new_value)
  end

  def clear_vote_for(user)
    vote_for(user).delete #TODO: destroy? #TODO: law of demetr
  end

  #check methods

  def already_upvoted_by?(user)
    upvoted_users.include? user
  end

  def already_downvoted_by?(user)
    downvoted_users.include? user
  end

  def already_voted_by?(user)
    voted_users.include? user
  end

  #voters info methods
  def vote_for(user)
    votes.where(user_id: user.id).first
  end

  def users_names_with_vote(vote)
    users_with_vote(vote).map(&:name)
  end

  def upvoted_users_count
    upvoted_users.count
  end

  def downvoted_users_count
    downvoted_users.count
  end

  private

  def vote_value_allowed?(vote_value)
    [UPVOTE_CONSTANT, DOWNVOTE_CONSTANT].include? vote_value
  end

  def voteable_class_name
    self.class.name
  end
end