module ContentQueries
  class OrderedByPosts
    def initialize(relation = Content.all)
      @relation = relation
    end

    def call
      @relation
        .joins(:posts)
        .group(:content_id)
        .order('count(*) desc')
    end
  end
end
