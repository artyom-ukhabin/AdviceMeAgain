module UserQueries
  class RatersForPersonalitiesArray
    def initialize(personalities_array, relation = User.all)
      @relation = relation
      @personalities_array = personalities_array
    end

    def call
      @relation
        .joins(:personality_rates)
        .where('personality_rates.personality_id IN (?)', @personalities_array)
        .distinct
    end
  end
end