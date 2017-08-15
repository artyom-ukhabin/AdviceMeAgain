class PersonalityReviews::VotesController < ApplicationController
  include VotesControllerMethods

  def index
    @personality_review = PersonalityReview.find(params[:personality_review_id])
    @users_names = set_voted_users_info(@personality_review, params[:vote_value])
    render :index
  end

  def create
    @personality_review = PersonalityReview.find(params[:personality_review_id])
    vote_value = params[:vote_value]
    if @personality_review.set_vote(current_user, vote_value)
      @votes_data = PersonalityDecorator.new.votes_data(@personality_review, current_user)
      render :update
    else
      render head: 500 #TODO: clarify
    end
  end

  def update
    @personality_review = PersonalityReview.find(params[:personality_review_id])
    @vote = PersonalityReviewVote.find(params[:id])
    new_value = params[:vote_value]
    if @personality_review.update_vote(@vote, new_value)
      @votes_data = PersonalityDecorator.new.votes_data(@personality_review, current_user)
      render :update
    else
      render head: 500 #TODO: clarify
    end
  end

  def destroy
    @personality_review = PersonalityReview.find(params[:personality_review_id])
    @vote = PersonalityReviewVote.find(params[:id])
    if @personality_review.clear_vote_for(current_user)
      @votes_data = PersonalityDecorator.new.votes_data(@personality_review, current_user)
      render :update
    else
      render head: 500 #TODO: clarify
    end
  end

  private

  def actual_params
    params_with_user(personality_review_vote_params)
  end

  def personality_review_vote_params
    params.require(:personality_review_vote).permit(:vote)
  end
end
