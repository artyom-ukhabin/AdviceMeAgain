class PersonalityDecorator
  def decorate(personality, user)
    decorated_personality = {}
    decorated_personality[:subject] = personality
    decorated_personality[:average_rating] = personality.average_rating
    decorated_personality[:user_rating] = personality.rating(user)
    decorated_personality
  end
end