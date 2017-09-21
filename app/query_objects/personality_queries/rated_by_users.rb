module PersonalityQueries
  class RatedByUsers
    def initialize(users_array, relation = Personality.all)
      @relation = relation
      @users_array = users_array
    end

    def call
      @relation
        .joins(:rates)
        .where('personality_rates.user_id IN (?)', @users_array)
        .distinct
    end
  end
end