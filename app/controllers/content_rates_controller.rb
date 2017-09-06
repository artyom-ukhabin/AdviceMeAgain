class ContentRatesController < ApplicationController
  include RatesControllerMethods

  def create
    @rate = ContentRate.new(actual_params)
    content = @rate.content
    updater = RateUpdater.new(@rate, content)
    if updater.save
      set_view_variables(content)
      render :update
    else
      render head: 500 #TODO: clarify
    end
  end

  def update
    @rate = ContentRate.find(params[:id])
    content = @rate.content
    updater = RateUpdater.new(@rate, content)
    if updater.update(actual_params)
      set_view_variables(content)
      render :update
    else
      render head: 500 #TODO: clarify
    end
  end

  def destroy
    @rate = ContentRate.find(params[:id])
    content = @rate.content
    updater = RateUpdater.new(@rate, content)
    if updater.destroy
      set_view_variables(content)
      set_new_rate(content, current_user_hash)
      render :update
    else
      render head: 500 #TODO: clarify
    end
  end

  private

  def actual_params
    params_with_user(content_rate_params)
  end

  def content_rate_params
    params.require(:content_rate).permit(:content_id, :value)
  end
end