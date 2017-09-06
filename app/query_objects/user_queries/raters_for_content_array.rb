module UserQueries
  class RatersForContentArray
    def initialize(content_array, relation = User.all)
      @relation = relation
      @content_array = content_array
    end

    def call
      @relation
        .joins(:content_rates)
        .where('content_rates.content_id IN (?)', @content_array)
        .distinct
    end
  end
end