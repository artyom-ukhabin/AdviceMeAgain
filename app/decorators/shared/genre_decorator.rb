module Shared
  class GenreDecorator
    def initialize
      @content_decorator = GenreContentDecorator.new
    end

    def decorate(genre)
      decorated_data = {}
      decorated_data[:genre] = genre
      decorated_data[:content_data] = @content_decorator.content_data(genre)
      decorated_data
    end
  end
end