class PersonalityDecorator
  include Decorable
  include DecorableWithRates
  include DecorableWithReviews

  def initialize
    @content_decorator = PersonalityContentDecorator.new
  end

  def for_index_action(personality, user)
    decorated_personality = initialize_hash(personality)
    decorated_personality.merge! decorated_ratings(personality, user)
    decorated_personality
  end

  def for_show_action(personality, user)
    decorated_personality = for_index_action(personality, user)
    decorated_personality[:content_data] = @content_decorator.content_data(personality)
    decorated_personality[:reviews_collection] = decorated_reviews(personality, user)
    decorated_personality[:new_review] = build_new_review(personality, user)
    decorated_personality
  end
end