module RatesControllerMethods
  def set_view_variables(rateable)
    @average_rating = rateable.average_rating
    @wrapper_id = "#{rateable.class.name.underscore}_#{rateable.id}"
  end

  def set_new_rate(rateable, user_data)
    @rate = rateable.rates.build(user_data)
  end
end