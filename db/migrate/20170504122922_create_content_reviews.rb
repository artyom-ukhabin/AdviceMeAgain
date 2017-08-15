class CreateContentReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :content_reviews do |t|
      t.text :body
      t.timestamps
    end
  end
end
