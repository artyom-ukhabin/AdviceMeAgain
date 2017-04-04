class CreateJoinTableContentPlatform < ActiveRecord::Migration[5.0]
  def change
    create_join_table :content, :platforms do |t|
      # t.index [:content_id, :platform_id] #TODO: think about indexes here
      # t.index [:platform_id, :content_id]
    end
  end
end
