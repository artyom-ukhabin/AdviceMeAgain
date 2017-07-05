class AddContentRefToContentReviews < ActiveRecord::Migration[5.0]
  def change
    add_reference :content_reviews, :content, foreign_key: true
  end
end
