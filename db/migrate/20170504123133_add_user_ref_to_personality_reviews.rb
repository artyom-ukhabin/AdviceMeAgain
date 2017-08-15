class AddUserRefToPersonalityReviews < ActiveRecord::Migration[5.0]
  def change
    add_reference :personality_reviews, :user, foreign_key: true
  end
end
