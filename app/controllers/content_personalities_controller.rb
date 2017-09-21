class ContentPersonalitiesController < ApplicationController
  #TODO: REST controllers - think more. Two types for edit action in closing case.
  def edit
    content = Content.find(params[:content_id])
    @personalities_data = ContentPersonalitiesDecorator.new.personalities_data(content)
    render 'content/personalities_section/show_form'
  end

  def create
    content = Content.find(params[:content_id])
    content.personality_ids = params[:personalities_ids]
    @personalities_data = ContentPersonalitiesDecorator.new.personalities_data(content)
    render 'content/personalities_section/update_section'
  end
end
