class ProfileDecorator
  include Decorable

  def initialize
    @post_decorator = PostDecorator.new
  end

  def for_show_action(profile, profile_owner, current_user)
    decorated_profile = initialize_hash(profile)
    decorated_profile[:posts_collection] = decorated_posts(profile_owner, current_user)
    decorated_profile[:new_post_data] = @post_decorator.new_post_data
    decorated_profile[:changes_allowed] = (profile_owner == current_user)
    decorated_profile
  end

  private

  def decorated_posts(profile_owner, current_user)
    posts_collection = []
    profile_owner.published_posts.each do |post|
      posts_collection << @post_decorator.show_post_data(post, current_user)
    end
    posts_collection
  end
end