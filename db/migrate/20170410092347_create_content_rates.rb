class CreateContentRates < ActiveRecord::Migration[5.0]
  def change
    create_table :content_rates do |t|
      t.references :content, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :rate

      t.timestamps
    end
  end
end
