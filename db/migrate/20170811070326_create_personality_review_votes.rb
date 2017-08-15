class CreatePersonalityReviewVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :personality_review_votes do |t|
      t.references :user, foreign_key: true
      t.references :personality_review, foreign_key: true
      t.integer :vote
      t.timestamps

      t.index([:user_id, :personality_review_id], unique: true, name: 'idx_prvotes_user_pr')
    end
  end
end
