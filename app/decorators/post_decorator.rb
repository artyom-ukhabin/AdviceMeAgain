class PostDecorator
  include Decorable

  def show_post_data(post, current_user)
    show_post_data = initialize_hash(post)
    show_post_data[:author_profile] = post.author_profile
    show_post_data[:content_data] = post.content_table_data #TODO: URGENT: get rid of n+1 queries everywhere
    show_post_data[:changes_allowed] = post.changeable_by?(current_user) #TODO: Change this when nesting with profile will be implemented
    show_post_data
  end

  def new_post_data
    new_post_data = initialize_hash(Post.new)
    new_post_data.merge! common_form_data
    new_post_data
  end

  def edit_post_data(post)
    edit_post_data = initialize_hash(post)
    raw_content_data = post.raw_sections_data
    edit_post_data[:content_data] = ContentPostParamsConverter.for_edit_post_form(raw_content_data)
    edit_post_data.merge! common_form_data
    edit_post_data
  end

  private

  def common_form_data
    form_data = {}
    section_options = get_section_types_options
    form_data[:max_sections_amount] = section_options.length
    form_data[:section_data] = section_data(section_options)
    form_data
  end

  def section_data(section_options)
    section_data = {}
    section_data[:section_types_options] = section_options
    section_data[:first_content_position] = ContentPost::FIRST_POSITION
    section_data
  end

  def get_section_types_options
    Content::TYPES.map { |type| [type.capitalize, type.pluralize] }
  end
end