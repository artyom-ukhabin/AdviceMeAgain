class RatesController < ApplicationController
  AVAILABLE_TYPES = %w(content personality)

  before_action :reject_unknown_rate_types

  def create
    @rate = rate_model.new(rate_params)
    respond_to do |format|
      format.js do
        if @rate.save
          set_view_variables
          render :update
        else
          render head: 500 #TODO: clarify
        end
      end
    end

  end

  def update
    @rate = rate_model.find(params[:id])
    respond_to do |format|
      format.js do
        if @rate.update(rate_params)
          set_view_variables
          render :update
        else
          render head: 500 #TODO: clarify
        end
      end
    end
  end

  def destroy
    @rate = rate_model.find(params[:id])
    respond_to do |format|
      format.js do
        if @rate.destroy
          set_view_variables
          set_new_rate
          render :update
        else
          render head: 500 #TODO: clarify
        end
      end
    end
  end

  private

  def reject_unknown_rate_types
    render head: 400 unless AVAILABLE_TYPES.include? rate_type
  end

  def set_view_variables
    @rateable = "#{rate_type.classify}".constantize.find(controller_params[:rateable_id])
    @average_rating = @rateable.average_rating
    @wrapper_id = "#{rate_type}_#{controller_params[:rateable_id]}"
  end

  def set_new_rate
    @rate = rate_model.new(rate_params.except(:value))
  end

  def rate_type
    @rate_type ||= params[:type]
  end

  def rate_model
    @rate_model ||= "#{rate_type.classify}Rate".constantize
  end

  def rateable_key
    "#{rate_type}_id".to_sym
  end

  def rate_params
    rate_params = controller_params.dup
    rate_params[rateable_key] = rate_params.delete(:rateable_id)
    rate_params
  end

  def controller_params
    params.require(:rate).permit(:user_id, :rateable_id, :value)
  end
end
