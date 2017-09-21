class PersonalityRatesController < ApplicationController
  include RatesControllerMethods

  def create
    @rate = PersonalityRate.new(actual_params)
    updater = RateUpdater.new(@rate)
    if updater.save
      set_view_variables(@rate.personality)
      render :update
    else
      render head: 500 #TODO: clarify
    end
  end

  def update
    @rate = PersonalityRate.find(params[:id])
    updater = RateUpdater.new(@rate)
    if updater.update(actual_params)
      set_view_variables(@rate.personality)
      render :update
    else
      render head: 500 #TODO: clarify
    end
  end

  def destroy
    @rate = PersonalityRate.find(params[:id])
    updater = RateUpdater.new(@rate)
    personality = @rate.personality
    if @rate.destroy
      set_view_variables(personality)
      set_new_rate(personality, current_user_hash)
      render :update
    else
      render head: 500 #TODO: clarify
    end
  end

  private

  def actual_params
    params_with_user(personality_rate_params)
  end

  def personality_rate_params
    params.require(:personality_rate).permit(:personality_id, :value)
  end
end