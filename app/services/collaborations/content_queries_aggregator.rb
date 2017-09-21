#TODO: do something with this
module Collaborations
  class ContentQueriesAggregator
    def initialize(items_type)
      @items_type = items_type
      @actual_relation = build_actual_type_relation(@items_type)
    end

    def find_highrated_items(user)
      ContentQueries::HighratedByUserQuery.new(user, @actual_relation).call
    end

    def find_lowrated_items(user)
      ContentQueries::LowratedByUserQuery.new(user, @actual_relation).call
    end

    def find_highrated_items_ids(user)
      ContentQueries::HighratedByUserQuery.new(user, @actual_relation).only_ids
    end

    def find_lowrated_items_ids(user)
      ContentQueries::LowratedByUserQuery.new(user, @actual_relation).only_ids
    end

    def find_users(items)
      UserQueries::RatersForContentArray.new(items).call
    end

    def find_items(users)
      ContentQueries::RatedByUsers.new(users, @actual_relation).call
    end

    private

    def build_actual_type_relation(items_type)
      Content.where(type: items_type)
    end
  end
end