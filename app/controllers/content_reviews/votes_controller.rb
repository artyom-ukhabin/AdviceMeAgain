module ContentReviews
  class VotesController < ApplicationController
    include VotesControllerMethods

    def index
      @content_review = ContentReview.find(params[:content_review_id])
      @users_names = set_voted_users_info(@content_review, params[:vote_value])
      render :index
    end

    def create
      @content_review = ContentReview.find(params[:content_review_id])
      vote_value = params[:vote_value]
      if @content_review.set_vote(current_user, vote_value)
        @votes_data = ContentDecorators::BaseDecorator.new.votes_data(@content_review, current_user)
        render :update
      else
        render head: 500 #TODO: clarify (clarified, its wrong)
      end
    end

    def update
      @content_review = ContentReview.find(params[:content_review_id])
      @vote = ContentReviewVote.find(params[:id])
      new_value = params[:vote_value]
      if @content_review.update_vote(@vote, new_value)
        @votes_data = ContentDecorators::BaseDecorator.new.votes_data(@content_review, current_user)
        render :update
      else
        render head: 500 #TODO: clarify
      end
    end

    def destroy
      @content_review = ContentReview.find(params[:content_review_id])
      @vote = ContentReviewVote.find(params[:id])
      if @content_review.clear_vote_for(current_user)
        @votes_data = ContentDecorators::BaseDecorator.new.votes_data(@content_review, current_user)
        render :update
      else
        render head: 500 #TODO: clarify
      end
    end

    private

    def actual_params
      params_with_user(content_review_vote_params)
    end

    def content_review_vote_params
      params.require(:content_review_vote).permit(:vote)
    end
  end
end
