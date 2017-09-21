module ContentQueries
  class OrderedByRating
    def initialize(relation = Content.all)
      @relation = relation
    end

    def call
      @relation
        .joins(:rates)
        .group(:content_id)
        .order('avg(content_rates.value) desc')
    end
  end
end
