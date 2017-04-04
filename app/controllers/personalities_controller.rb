class PersonalitiesController < InheritedResources::Base

  private

    def personality_params
      params.require(:personality).permit(:name, :born_date, :death_date, :info)
    end
end

