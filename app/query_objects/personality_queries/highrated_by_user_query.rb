module PersonalityQueries
  class HighratedByUserQuery
    def initialize(user, relation = Personality.all)
      @rated_by_users_query = PersonalityQueries::RatedByUsers.new([user], relation)
    end

    def call
      @rated_by_users_query.call.where('personality_rates.value IN (?)', PersonalityRate::HIGH_RATES)
    end

    def only_ids
      call.pluck(:id)
    end
  end
end