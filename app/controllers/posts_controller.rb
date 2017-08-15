class PostsController < ApplicationController
  #TODO: clear focus on post when click on another edit link
  def edit
    @post = Post.find(params[:id])
    forbid_changes_for_strangers!(@post)
    @post_data = PostDecorator.new.edit_post_data(@post)
    render :edit_post
  end

  #TODO: 1. add positions to edit_data
  #TODO: 2. n+1 queries
  #TODO: 3. likes for review and posts

  def show
    @post = Post.find(params[:id])
    @post_data = PostDecorator.new.show_post_data(@post, current_user)
    render :show_post
  end

  def create
    @post = Post.new(actual_params)
    if @post.save
      @post.set_publisher(current_user)
      @post_data = PostDecorator.new.show_post_data(@post, current_user)
      render :add_post
    else
      render head: 500 #TODO: clarify
    end
  end

  def update
    @post = Post.find(params[:id])
    forbid_changes_for_strangers!(@post)
    @post.content_posts = []
    if @post.update(actual_params)
      @post_data = PostDecorator.new.show_post_data(@post, current_user)
      render :update_post
    else
      render head: 500 #TODO: clarify
    end
  end

  def destroy
    @post = Post.find(params[:id])
    forbid_changes_for_strangers!(@post)
    if @post.destroy
      @post.delete_publisher(current_user)
      render :delete_post
    else
      render head: 500 #TODO: clarify
    end
  end

  private

  def forbid_changes_for_strangers!(post)
    redirect_to root_path unless post.changeable_by?(current_user)
  end

  def actual_params
    converted_params = ContentPostParamsConverter.for_post_controller(post_params)
    converted_params.merge!(author_hash)
    converted_params
  end

  def author_hash
    {author_id: current_user.id}
  end

  def post_params
    params.require(:post).permit(:title, raw_content_posts_attributes: [:name, :position])
  end
end