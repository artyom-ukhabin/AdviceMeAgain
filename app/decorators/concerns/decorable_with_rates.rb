module DecorableWithRates
  def decorated_ratings(rateable, user)
    rating_hash = {}
    rating_hash[:average_rating] = rateable.average_rating
    rating_hash[:user_rating] = rateable.rating(user)
    rating_hash
  end
end