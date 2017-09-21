module ContentDecorators
  class BaseDecorator
    include Decorable
    include DecorableWithRates
    include DecorableWithReviews

    def initialize
      @personality_decorator = ContentPersonalitiesDecorator.new
    end

    def for_index_action(content, user)
      decorated_content = initialize_hash(content)
      decorated_content.merge! decorated_ratings(content, user)
      decorated_content.merge! subclass_index_data(content, user)
      decorated_content
    end

    #TODO: later unify review units in one review_data
    def for_show_action(content, user)
      decorated_content = for_index_action(content, user)
      decorated_content[:personalities_data] = @personality_decorator.personalities_data(content)
      decorated_content[:reviews_collection] = decorated_reviews(content, user)
      decorated_content[:new_review] = build_new_review(content, user)
      decorated_content.merge! subclass_show_data(content, user)
      decorated_content
    end

    private

    def subclass_index_data(content, user)
      {}
    end

    def subclass_show_data(content, user)
      {}
    end
  end
end