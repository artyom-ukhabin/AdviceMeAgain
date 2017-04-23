module Rateable
  def rating(user)
    #TODO: refactor at any cost
    rates.for_user(user).first || "#{rateable_class_name}Rate".constantize.new(user_id: user.to_param,
      "#{rateable_class_name.underscore}_id".to_sym => self.to_param)
  end

  def average_rating
    rates.average(:value)
  end

  private

  def rateable_class_name
    #TODO: well...
    (self.is_a? Content) ? 'Content' : self.class.name
  end
end