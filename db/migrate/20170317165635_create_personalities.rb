class CreatePersonalities < ActiveRecord::Migration[5.0]
  def change
    create_table :personalities do |t|
      t.string :name
      t.date :born_date
      t.date :death_date
      t.text :info

      t.timestamps
    end
  end
end
