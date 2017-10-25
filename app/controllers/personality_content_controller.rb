class PersonalityContentController < ApplicationController
  #TODO: REST controllers - think more. Two types for edit action in closing case.
  def edit
    personality = Personality.find(params[:personality_id])
    @new_relations_data = PersonalityContentDecorator.new.new_relations_data(personality)
    render 'personalities/content_section/show_form'
  end

  def create
    personality = Personality.find(params[:personality_id])
    updater = PersonalityContentUpdater.new(personality)
    updater.content_ids = params[:content_ids]
    @content_data = PersonalityContentDecorator.new.content_data(personality)
    render 'personalities/content_section/update_section'
  end
end
