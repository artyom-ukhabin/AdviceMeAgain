module RatesHelper
  def rater_id
    current_user.to_param
  end

  def rate_url(rate)
    "/#{rate.class.name.underscore.pluralize}/"
  end

  def show_cansel_button?(rate)
    rate.persisted?
  end
end
