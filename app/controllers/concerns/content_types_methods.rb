module ContentTypesMethods
  def set_types(params_type)
    type = check_type(params_type)
    type ? [type] : Content::TYPES #TODO: make url more native
  end

  #TODO: model method?
  def check_type(type)
    Content.check_type(type)
  end

  def current_model(content_type)
    content_type.classify.constantize
  end
end