class ContentController < ApplicationController
  def index
    @content_data = []
    current_types = set_types
    current_types.each do |content_type|
      @content_data << build_single_type_array(content_type)
    end
  end

  def show
    content = Content.find(params[:id])
    decorated_content = ContentDecorators::ContentDecorator.for_show_action(content, current_user)
    render "#{current_type.tableize}/show", locals: {content_data: decorated_content}
  end

  def new
    @type = current_type
    @content = Content.new(type: @type.classify)
  end

  def edit
    @content = Content.find(params[:id])
    @type = current_type
  end

  def create
    #TODO: handle with this shit
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
    params.require(current_type.underscore.to_sym).permit(:name, :genre, :year, :info, :timing)
  end

  def set_types
    type = current_type
    type ? [type] : Content::TYPES #TODO: make url more native
  end

  def current_type
    params[:type] if Content::TYPES.include?(params[:type])
  end

  def build_single_type_array(content_type)
    specific_type_data = []
    content_type.classify.constantize.all.each do |content|
      specific_type_data << ContentDecorators::ContentDecorator.for_index_action(content, current_user)
    end
    specific_type_data
  end
end
