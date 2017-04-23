#TODO: unify with content_rate, DRY <<< HIGH PRIORITY
class PersonalityRatesController < ApplicationController
  def create
    @personality_rate = PersonalityRate.new(personality_rate_params)
    if @personality_rate.save
      render :update
    else
      render head: 500 #TODO: clarify
    end
  end

  def update
    @personality_rate = PersonalityRate.find(params[:id])
    if @personality_rate.update(personality_rate_params)
      render :update
    else
      render head: 500 #TODO: clarify
    end
  end

  def delete
    @personality_rate = PersonalityRate.find(params[:id])
    if @personality_rate.destroy
      render :update
    else
      render head: 500 #TODO: clarify
    end
  end

  private

  def personality_rate_params
    params.require(:personality_rate).permit(:rate)
  end
end
