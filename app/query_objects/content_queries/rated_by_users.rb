module ContentQueries
  class RatedByUsers
    def initialize(users_array, relation = Content.all)
      @relation = relation
      @users_array = users_array
    end

    def call
      @relation
        .joins(:rates)
        .where('content_rates.user_id IN (?)', @users_array)
        .distinct
    end
  end
end