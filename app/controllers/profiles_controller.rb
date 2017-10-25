class ProfilesController < ApplicationController
  # GET /profiles/1
  # GET /profiles/1.json
  def show
    profile = Profile.find(params[:id])
    profile_owner = profile.user
    @profile_data = ProfileDecorator.new.for_show_action(profile, profile_owner, current_user)
  end

  # GET /profiles/new
  def new
    @user = current_user
    @profile = @user.build_profile
  end

  # GET /profiles/1/edit
  def edit
    @profile = Profile.find(params[:id])
    forbid_changes_for_strangers!(@profile); return if performed?
  end

  # POST /profiles
  # POST /profiles.json
  def create
    #TODO: disable content_type before send data
    @user = current_user
    @profile = @user.build_profile(profile_params)

    respond_to do |format|
      if @profile.save
        format.html { redirect_to @profile, notice: 'Profile was successfully created.' }
        format.json { render :show, status: :created, location: @profile }
      else
        format.html { render :new }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update
    @profile = Profile.find(params[:id])
    forbid_changes_for_strangers!(@profile); return if performed?
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    @profile = Profile.find(params[:id])
    forbid_changes_for_strangers!(@profile); return if performed?
    @profile.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def forbid_changes_for_strangers!(profile) #TODO: think about pundit/cancan
    redirect_to root_path unless profile.changeable_by?(current_user)
  end

  def profile_params
    params.require(:profile).permit(:name, :city, :info)
  end
end