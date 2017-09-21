#TODO: if several actions - something like in POODR with duck types
class RateUpdater
  def initialize(rate, item)
    @rate = rate
    @updaters = fill_updaters(rate, item)
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

  def fill_updaters(rate, item)
    updaters = []
    updaters << RateUpdater::CollaborationsUpdater.new(rate, item)
    updaters
  end

  def update_rate(updaters)
    updaters.each do |updater|
      updater.update
    end
  end
end