class AddUserRefToContentReviews < ActiveRecord::Migration[5.0]
  def change
    add_reference :content_reviews, :user, foreign_key: true
  end
end
