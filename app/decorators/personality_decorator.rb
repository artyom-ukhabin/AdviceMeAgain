class PersonalityDecorator
  include Decorable
  include DecorableWithRates
  include DecorableWithReviews

  def for_index_action(personality, user)
    decorated_content = initialize_hash(personality)
    decorated_content.merge! decorated_ratings(personality, user)
    decorated_content
  end

  def for_show_action(personality, user)
    decorated_content = for_index_action(personality, user)
    decorated_content[:reviews_collection] = decorated_reviews(personality, user)
    decorated_content[:new_review] = build_new_review(personality, user)
    decorated_content
  end
end