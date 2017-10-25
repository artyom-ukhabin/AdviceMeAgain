class ContentController < ApplicationController
  layout "with_recommendations_section", only: [:index, :show]

  include ContentTypesMethods

  def index
    current_types = set_types(params[:type])
    @content_data = set_index_data(current_types)
    @layout_data = RandomRecommendation::Fetcher.new(current_types).get_recommendation(current_user)
  end

  def show
    content = Content.find(params[:id])
    current_type = check_type(params[:type])
    decorated_content = ContentDecorators.data_for_show_action(content, current_user)
    @layout_data = RandomRecommendation::Fetcher.new([current_type]).get_recommendation(current_user)
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
    current_type = check_type(params[:type])
    @content = content_class(current_type).new(content_params)
    updater = ContentUpdater.new(@content)
    if updater.save
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
    updater = ContentUpdater.new(@content)
    updater.destroy
    #TODO: rewrite with url helper method
    #TODO: think when and where redirect after destroy
    redirect_to "/#{type.tableize}", notice: "#{type} was successfully destroyed."
  end

  private

  def content_class(current_type)
    current_type.classify.constantize
  end

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
    data = {}
    data[:type] = content_type
    data[:collection] = build_single_type_collection(content_type)
    data
  end

  def build_single_type_collection(content_type)
    current_model(content_type).all.inject([]) do |specific_type_data, content|
      specific_type_data << ContentDecorators.data_for_index_action(content, current_user)
    end
  end
end
