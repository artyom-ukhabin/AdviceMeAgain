class ChangeUsersRole < ActiveRecord::Migration[5.0]
  def up
    change_table :users do |t|
      t.change :role, :integer
    end
  end

  def down
    change_table :users do |t|
      t.change :role, :string
    end
  end
end
