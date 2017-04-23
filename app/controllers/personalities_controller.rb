class PersonalitiesController < InheritedResources::Base
  def index
    @personalities_collection = Personality.all.map do |personality|
      PersonalityDecorator.new.decorate(personality, current_user)
    end
  end

  def show
    personality = Personality.find(params[:id])
    @personality_data = PersonalityDecorator.new.decorate(personality, current_user)
  end

  def new
    @personality = Personality.new
  end

  def edit
    @personality = Personality.find(params[:id])
  end

  def create
    @personality = Personality.new(personality_params)
    respond_to do |format|
      if @personality.save
        format.html { redirect_to @personality, notice: 'Personality was successfully created.' }
        format.json { render :show, status: :created, location: @personality}
      else
        format.html { render :new }
        format.json { render json: @personality.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @personality = Personality.find(params[:id])
    respond_to do |format|
      if @personality.update(personality_params)
        format.html { redirect_to @personality, notice: 'Personality was successfully updated.' }
        format.json { render :show, status: :ok, location: @personality}
      else
        format.html { render :edit }
        format.json { render json: @personality.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @personality = Personality.find(params[:id])
    @personality.destroy
    respond_to do |format|
      format.html { redirect_to personalities_path, notice: 'Personality was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def personality_params
    params.require(:personality).permit(:name, :born_date, :death_date, :info)
  end
end

