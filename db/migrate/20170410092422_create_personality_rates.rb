class CreatePersonalityRates < ActiveRecord::Migration[5.0]
  def change
    create_table :personality_rates do |t|
      t.references :personality, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :rate

      t.timestamps
    end
  end
end
