module ContentDecorators
  class GameDecorator < BaseDecorator
    def subclass_index_data(game, user)
      build_platforms_hash(game)
    end

    def subclass_show_data(game, user)
      build_platforms_hash(game)
    end

    private

    def build_platforms_hash(game)
      additional_data = {}
      additional_data[:platforms] = decorated_platforms(game)
      additional_data
    end

    def decorated_platforms(game)
      game.platforms.map(&:name).join(" ")
    end
  end
end
