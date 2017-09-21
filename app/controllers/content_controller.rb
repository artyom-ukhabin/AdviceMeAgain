class ContentController < ApplicationController
  include ContentTypesMethods

  def index
    current_types = set_types(params[:type])
    @content_data = set_index_data(current_types)
  end

  def show
    content = Content.find(params[:id])
    current_type = check_type(params[:type])
    decorated_content = ContentDecorators.data_for_show_action(content, current_user)
    render "/content/#{current_type.tableize}/show", locals: {content_data: decorated_content}
  end

  def new
    @type = check_type(params[:type])
    @content = Content.new(type: @type.classify)
  end

  def edit
    @content = Content.find(params[:id])
    @type = check_type(params[:type])
  end

  def create
    #TODO: handle with this shit
    current_type = check_type(params[:type])
    content_class = current_type.classify.constantize
    @content = content_class.new(content_params)
    if @content.save
      redirect_to @content, notice: "#{@content.type} was successfully created."
    else
      render :new
    end
  end

  def update
    @content = Content.find(params[:id])
    if @content.update(content_params)
      redirect_to @content, notice: "#{@content.type} was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @content = Content.find(params[:id])
    type = @content.type
    @content.destroy
    #TODO: rewrite with url helper method
    #TODO: think when and where redirect after destroy
    redirect_to "/#{type.tableize}", notice: "#{type} was successfully destroyed."
  end

  private

  def content_params
    #TODO: think about it
    current_type = check_type(params[:type])
    params.require(current_type.underscore.to_sym).permit(:name, :genre, :year, :info, :timing)
  end

  def set_index_data(current_types)
    current_types.inject([]) do |data, content_type|
      data << build_single_type_array(content_type)
    end
  end

  def build_single_type_array(content_type)
    current_model(content_type).all.inject([]) do |specific_type_data, content|
      specific_type_data << ContentDecorators.data_for_index_action(content, current_user)
    end
  end
end
