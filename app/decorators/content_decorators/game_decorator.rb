module ContentDecorators
  class GameDecorator
    def decorate(game, user)
      decorated_game = {}
      decorated_game[:subject] = game
      decorated_game[:average_rating] = game.average_rating
      decorated_game[:user_rating] = game.rating(user)
      decorated_game[:platforms] = decorated_platforms(game)
      decorated_game
    end

    private

    def decorated_platforms(game)
      game.platforms.map(&:name).join(" ")
    end
  end
end
