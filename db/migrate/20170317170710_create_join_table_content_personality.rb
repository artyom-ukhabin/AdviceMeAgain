class CreateJoinTableContentPersonality < ActiveRecord::Migration[5.0]
  def change
    create_join_table :content, :personalities do |t|
      # t.index [:content_id, :personality_id]
      # t.index [:personality_id, :content_id]
    end
  end
end
