#TODO: think about folders organization (and for views too)
class Posts::LikesController < ApplicationController
  def index
    @post = Post.find(params[:post_id])
    @liked_users_names = set_liked_users_info(@post)
    render :index
  end

  def create
    @post = Post.find(params[:post_id])
    if @post.liked_by(current_user)
      @likes_data = PostDecorator.new.likes_data(current_user, @post)
      render :update
    else
      render head: 500 #TODO: clarify
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    if @post.remove_user_like(current_user)
      @likes_data = PostDecorator.new.likes_data(current_user, @post)
      render :update
    else
      render head: 500 #TODO: clarify
    end
  end

  private

  def set_liked_users_info(post)
    user_names = post.liked_users_names
    return user_names unless user_names.blank?
    'No likes yet'
  end
end
