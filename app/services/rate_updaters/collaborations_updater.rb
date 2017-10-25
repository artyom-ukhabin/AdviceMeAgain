module RateUpdaters
  class CollaborationsUpdater
    def initialize(rate, item)
      @rater = rate.user
      @items_type = item.class.name
      @worker_class = UpdateCollaborationsWorker
    end

    def update
      @worker_class.perform_async(@items_type, @rater.id)
    end
  end
end