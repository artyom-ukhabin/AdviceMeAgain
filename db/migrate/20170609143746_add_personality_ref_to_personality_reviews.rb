class AddPersonalityRefToPersonalityReviews < ActiveRecord::Migration[5.0]
  def change
    add_reference :personality_reviews, :personality, foreign_key: true
  end
end
