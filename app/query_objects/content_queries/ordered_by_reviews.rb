module ContentQueries
  class OrderedByReviews
    def initialize(relation = Content.all)
      @relation = relation
    end

    def call
      @relation
        .joins(:reviews)
        .group(:content_id)
        .order('count(*) desc')
    end
  end
end
