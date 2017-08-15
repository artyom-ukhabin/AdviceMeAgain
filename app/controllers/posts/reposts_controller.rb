class Posts::RepostsController < ApplicationController
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

  def show
    @post = Post.find(params[:post_id])
    @repost_owners_names = set_repost_owners_info(@post)
    render :show #TODO: popup
  end

  def create
    @post = Post.find(params[:post_id])
    if current_user.can_repost?(@post)
      @post.set_publisher(current_user)
      render :create #TODO: popup
    else
      redirect_to profile_path(current_user.profile)
    end
  end

  private

  def set_repost_owners_info(post)
    return post.repost_owners_names unless post.repost_owners_names.blank?
    'No repost owners yet'
  end
end
