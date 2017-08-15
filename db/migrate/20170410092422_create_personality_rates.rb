class CreatePersonalityRates < ActiveRecord::Migration[5.0]
  def change
    create_table :personality_rates do |t|
      t.references :personality, foreign_key: true, null: false
      t.references :user, foreign_key: true, null: false
      t.integer :rate

      t.timestamps
    end
  end
end
