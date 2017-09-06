#TODO: do something with this
module Collaborations
  class PersonalityQueriesAggregator
    def find_highrated_items(user, _)
      PersonalityQueries::HighratedByUserQuery.new(user).call
    end

    def find_lowrated_items(user, _)
      PersonalityQueries::LowratedByUserQuery.new(user).call
    end

    def find_highrated_items_ids(user, _)
      PersonalityQueries::HighratedByUserQuery.new(user).only_ids
    end

    def find_lowrated_items_ids(user, _)
      PersonalityQueries::LowratedByUserQuery.new(user).only_ids
    end

    def find_users(items)
      UserQueries::RatersForPersonalitiesArray.new(items).call
    end

    def find_items(users, _)
      PersonalityQueries::RatedByUsers.new(users).call
    end
  end
end