#TODO: do something with this
module Collaborations
  class PersonalityQueriesAggregator
    def initialize(_) end

    def find_highrated_items(user)
      PersonalityQueries::HighratedByUserQuery.new(user).call
    end

    def find_lowrated_items(user)
      PersonalityQueries::LowratedByUserQuery.new(user).call
    end

    def find_highrated_items_ids(user)
      PersonalityQueries::HighratedByUserQuery.new(user).only_ids
    end

    def find_lowrated_items_ids(user)
      PersonalityQueries::LowratedByUserQuery.new(user).only_ids
    end

    def find_users(items)
      UserQueries::RatersForPersonalitiesArray.new(items).call
    end

    def find_items(users)
      PersonalityQueries::RatedByUsers.new(users).call
    end
  end
end