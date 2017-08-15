class ChangePersonalityRatesRateColumnName < ActiveRecord::Migration[5.0]
  def change
    rename_column :personality_rates, :rate, :value
  end
end
