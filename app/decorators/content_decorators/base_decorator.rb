module ContentDecorators
  class BaseDecorator
    include Decorable
    include DecorableWithRates
    include DecorableWithReviews

    def for_index_action(content, user)
      decorated_content = initialize_hash(content)
      decorated_content.merge! decorated_ratings(content, user)
      decorated_content.merge! subclass_index_data(content, user)
      decorated_content
    end

    def for_show_action(content, user)
      decorated_content = for_index_action(content, user)
      decorated_content[:reviews_collection] = decorated_reviews(content)
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