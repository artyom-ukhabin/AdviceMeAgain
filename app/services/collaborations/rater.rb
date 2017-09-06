module Collaborations
  class Rater
    def initialize(items_type, queries_aggregator)
      @items_type = items_type
      @queries_aggregator = queries_aggregator
    end

    def find_highrated_items(user)
      @queries_aggregator.find_highrated_items(user, @items_type).to_a
    end

    def find_lowrated_items(user)
      @queries_aggregator.find_lowrated_items(user, @items_type).to_a
    end

    #TODO: unify interface

    def find_highrated_items_ids(user)
      @queries_aggregator.find_highrated_items_ids(user, @items_type)
    end

    def find_lowrated_items_ids(user)
      @queries_aggregator.find_lowrated_items_ids(user, @items_type)
    end

    def find_users(items)
      @queries_aggregator.find_users(items).to_a
    end

    def find_items(users)
      @queries_aggregator.find_items(users, @items_type).to_a
    end
  end
end
