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

  #TODO: make vk.com-like reposts, which means
  #TODO: 1. change current single representation of post to post->post parent-child relation
  #TODO: 2. create new child post when repost, parent - post which had been reposted
  #TODO: 3. new author of this child post - previous publisher, the eldest post - original author
  #TODO: 4. parent likes and reposts = sum of child's likes and reposts
  #TODO: 5. add html link to post in addition to js
  #TODO: 6. make post routes nested in profile's routes for get actual author and publisher
  #TODO: 7. exclude author from publishers list and simplify receiving publishers list
  #TODO: 8. thanks to cloning posts add 'published_date' attribute to each post and receive posts for profile as
  #TODO:      (published+authored).order(:published_date)
  #TODO: 9. think about changes that new author can do in his own post with repost
  def repost
    @post = Post.find(params[:id])
    if current_user.can_repost?(@post)
      @post.set_publisher(current_user)
      render :repost_post  #TODO: popup
    else
      redirect_to profile_path(current_user.profile)
    end
  end

  def repost_owners
    @post = Post.find(params[:id])
    @repost_owners_names = set_repost_owners_info(@post)
    render :repost_owners #TODO: popup
  end

  private

  def forbid_changes_for_strangers!(post)
    redirect_to root_path unless post.changeable_by?(current_user)
  end

  def set_repost_owners_info(post)
    return post.repost_owners_names unless post.repost_owners_names.blank?
    'No repost owners yet'
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