class ChangeContentRatesRateColumnName < ActiveRecord::Migration[5.0]
  def change
    rename_column :content_rates, :rate, :value
  end
end
