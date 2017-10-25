class ContentRateUpdater
  CONTENT_BASED_WORKER_CLASS = ContentBasedFiltering::UpdateUserContentPreferencesWorker

  def initialize(rate, content)
    @rate = rate
    @updaters = fill_updaters(rate, content)
  end

  def save
    if @rate.save
      update_rate(@updaters)
    end
  end

  def update(rate_params)
    if @rate.update(rate_params)
      update_rate(@updaters)
    end
  end

  def destroy
    if @rate.destroy
      update_rate(@updaters)
    end
  end

  private

  def fill_updaters(rate, content)
    updaters = []
    updaters << RateUpdaters::CollaborationsUpdater.new(rate, content)
    updaters << RateUpdaters::ContentBasedUpdater.new(rate, content, CONTENT_BASED_WORKER_CLASS)
    updaters
  end

  def update_rate(updaters)
    updaters.each do |updater|
      updater.update
    end
  end
end