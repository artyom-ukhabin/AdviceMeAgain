class ContentReviewsController < Base::ReviewsController
  def edit
    @content_review = ContentReview.find(params[:id])
    render :edit_review
  end

  def create
    @content_review = ContentReview.new(actual_params)
    @review_data = Shared::ReviewDecorator.new.decorate(@content_review, current_user)
    if @content_review.save
      render :add_review
    else
      render head: 500 #TODO: clarify
    end
  end

  def update
    @content_review = ContentReview.find(params[:id])
    @review_data = Shared::ReviewDecorator.new.decorate(@content_review, current_user)
    if @content_review.update(actual_params)
      render :update_review
    else
      render head: 500 #TODO: clarify
    end
  end

  def destroy
    #TODO: implement first level redo logic on client side
    @content_review = ContentReview.find(params[:id])
    if @content_review.destroy
      render :delete_review
    else
      render head: 500 #TODO: clarify
    end
  end

  private

  def actual_params
    params_with_user(content_review_params)
  end

  def content_review_params
    params.require(:content_review).permit(:body, :content_id)
  end
end
