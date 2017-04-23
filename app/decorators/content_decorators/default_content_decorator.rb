#TODO: fix create ability from the outside
module ContentDecorators
  class DefaultContentDecorator
    def decorate(content, user)
      decorated_content = {}
      decorated_content[:subject] = content
      decorated_content[:average_rating] = content.average_rating
      decorated_content[:user_rating] = content.rating(user)
      decorated_content
    end
  end
end