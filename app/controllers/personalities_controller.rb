class PersonalitiesController < ApplicationController
  def index
    respond_to do |format|
      format.html { @personalities_collection = set_index_data }
      format.js { render json: set_filtered_data(params[:term]) }
    end
  end

  def show
    personality = Personality.find(params[:id])
    @personality_data = PersonalityDecorator.new.for_show_action(personality, current_user)
  end

  def new
    @personality = Personality.new
  end

  def edit
    @personality = Personality.find(params[:id])
  end

  def create
    @personality = Personality.new(personality_params)
    if @personality.save
      redirect_to @personality, notice: 'Personality was successfully created.'
    else
      render :new
    end
  end

  def update
    @personality = Personality.find(params[:id])
    if @personality.update(personality_params)
      redirect_to @personality, notice: 'Personality was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @personality = Personality.find(params[:id])
    @personality.destroy
    redirect_to personalities_path, notice: 'Personality was successfully destroyed.'
  end

  private

  def set_index_data
    Personality.all.map do |personality|
      PersonalityDecorator.new.for_index_action(personality, current_user)
    end
  end

  def set_filtered_data(term)
    Personality.autocomplete_data(term)
  end

  def personality_params
    params.require(:personality).permit(:name, :born_date, :death_date, :info)
  end
end

