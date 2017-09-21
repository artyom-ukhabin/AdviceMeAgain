module VotesHelper
  #TODO: read about drapper
  def upvote_section(votes_data, voteable)
    #TODO: make unique key in db
    default_upvote_section(votes_data, voteable)
  end

  def downvote_section(votes_data, voteable)
    default_downvote_section(votes_data, voteable)
  end

  def upvote_users_link(count, voteable)
    default_users_link(count, voteable, upvote_value_param)
  end

  def downvoted_users_link(count, voteable)
    default_users_link(count, voteable, downvote_value_param)
  end

  def already_voted?(votes_data)
    votes_data[:already_upvoted] || votes_data[:already_downvoted]
  end

  def destroy_vote_link(votes_data, voteable)
    link_to 'Delete vote', public_send("#{review_class_name(voteable).underscore}_vote_path", voteable, votes_data[:vote]),
      method: :delete, remote: true
  end

  private

  def default_upvote_section(votes_data, voteable)
    if votes_data[:already_upvoted]
      "Upvoted"
    elsif votes_data[:already_downvoted]
      default_update_vote_link('Upvote', upvote_value_param, voteable, votes_data[:vote])
    else
      default_create_vote_link('Upvote', upvote_value_param, voteable)
    end
  end

  def default_downvote_section(votes_data, voteable)
    if votes_data[:already_downvoted]
      "Downvoted"
    elsif votes_data[:already_upvoted]
      default_update_vote_link('Downvote', downvote_value_param, voteable, votes_data[:vote])
    else
      default_create_vote_link('Downvote', downvote_value_param, voteable)
    end
  end

  #TODO: get rid of send
  def default_create_vote_link(name, value_param, voteable)
    link_to name, public_send("#{review_class_name(voteable).underscore}_votes_path", voteable, value_param),
      remote: true, method: :post, class: "user_vote"
  end

  #TODO: get rid of send
  def default_update_vote_link(name, value_param, voteable, vote)
    link_to name, public_send("#{review_class_name(voteable).underscore}_vote_path", voteable, vote, value_param),
      remote: true, method: :patch, class: "user_vote"
  end

  def default_users_link(count, voteable, value_param)
    link_to count, public_send("#{review_class_name(voteable).underscore}_votes_path", voteable, value_param), remote: true
  end

  #TODO: think about making some constants global and use them in routes.rb
  #TODO: think about where these hashes belong
  def upvote_value_param
    {vote_value: Voteable::UPVOTE_CONSTANT}
  end

  def downvote_value_param
    {vote_value: Voteable::DOWNVOTE_CONSTANT}
  end

  def review_class_name(voteable)
    voteable.class.name
  end
end