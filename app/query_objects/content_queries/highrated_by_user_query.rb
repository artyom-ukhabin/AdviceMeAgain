module ContentQueries
  class HighratedByUserQuery
    def initialize(user, relation = Content.all)
      @rated_by_users_query = ContentQueries::RatedByUsers.new([user], relation)
    end

    def call
      @rated_by_users_query.call.where('content_rates.value IN (?)', ContentRate::HIGH_RATES)
    end

    def only_ids
      call.pluck(:id)
    end
  end
end