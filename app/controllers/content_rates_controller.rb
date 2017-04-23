class ContentRatesController < ApplicationController
  def create
    @content_rate = ContentRate.new(content_rate_params)
    if @content_rate.save
      render :update
    else
      render head: 500 #TODO: clarify
    end
  end

  def update
    @content_rate = ContentRate.find(params[:id])
    if @content_rate.update(content_rate_params)
      render :update
    else
      render head: 500 #TODO: clarify
    end
  end

  def delete
    @content_rate = ContentRate.find(params[:id])
    if @content_rate.destroy
      render :update
    else
      render head: 500 #TODO: clarify
    end
  end

  private

  def content_rate_params
    params.require(:content_rate).permit(:rate)
  end
end
