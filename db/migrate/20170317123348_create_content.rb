class CreateContent < ActiveRecord::Migration[5.0]
  def change
    create_table :content do |t|
      t.string :name
      t.string :year
      t.string :genre
      t.string :info
      t.integer :timing
      t.string :type

      t.timestamps
    end
  end
end
