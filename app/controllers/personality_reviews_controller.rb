class PersonalityReviewsController < Base::ReviewsController
  def edit
    @personality_review = PersonalityReview.find(params[:id])
    render :edit_review
  end

  def create
    @personality_review = PersonalityReview.new(actual_params)
    @review_data = Shared::ReviewDecorator.new.decorate(@personality_review, current_user)
    if @personality_review.save
      render :add_review
    else
      render head: 500 #TODO: clarify
    end
  end

  def update
    @personality_review = PersonalityReview.find(params[:id])
    @review_data = Shared::ReviewDecorator.new.decorate(@personality_review, current_user)
    if @personality_review.update(actual_params)
      render :update_review
    else
      render head: 500 #TODO: clarify
    end
  end

  def destroy
    #TODO: implement first level redo logic on client side
    @personality_review = PersonalityReview.find(params[:id])
    if @personality_review.destroy
      render :delete_review
    else
      render head: 500 #TODO: clarify
    end
  end

  private

  def actual_params
    params_with_user(personality_review_params)
  end

  def personality_review_params
    params.require(:personality_review).permit(:body, :personality_id)
  end
end
