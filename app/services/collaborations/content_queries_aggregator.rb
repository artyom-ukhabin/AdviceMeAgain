#TODO: do something with this
module Collaborations
  class ContentQueriesAggregator
    def find_highrated_items(user, items_type)
      actual_relation = build_actual_type_relation(items_type)
      ContentQueries::HighratedByUserQuery.new(user, actual_relation).call
    end

    def find_lowrated_items(user, items_type)
      actual_relation = build_actual_type_relation(items_type)
      ContentQueries::LowratedByUserQuery.new(user, actual_relation).call
    end

    def find_highrated_items_ids(user, items_type)
      actual_relation = build_actual_type_relation(items_type)
      ContentQueries::HighratedByUserQuery.new(user, actual_relation).only_ids
    end

    def find_lowrated_items_ids(user, items_type)
      actual_relation = build_actual_type_relation(items_type)
      ContentQueries::LowratedByUserQuery.new(user, actual_relation).only_ids
    end

    def find_users(items)
      UserQueries::RatersForContentArray.new(items).call
    end

    def find_items(users, items_type)
      actual_relation = build_actual_type_relation(items_type)
      ContentQueries::RatedByUsers.new(users, actual_relation).call
    end

    private

    def build_actual_type_relation(items_type)
      Content.where(type: items_type)
    end
  end
end