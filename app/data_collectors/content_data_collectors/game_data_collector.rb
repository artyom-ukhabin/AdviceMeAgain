module ContentDataCollectors
  class GameDataCollector
    def collect(game)
      collection = {}
      collection[:content] = game
      collection[:platforms] = game.platforms
      collection
    end
  end
end
