module RateUpdaters
  class ContentBasedUpdater
    def initialize(rate, item, worker_class)
      @rater = rate.user
      @item = item
      @worker_class = worker_class
    end

    def update
      @worker_class.perform_async(@item.id, @rater.id)
    end
  end
end