module RatesHelper
  def rate_url(rate)
    "/#{rate.class.name.underscore.pluralize}/"
  end

  def show_cansel_button?(rate)
    rate.persisted?
  end
end
