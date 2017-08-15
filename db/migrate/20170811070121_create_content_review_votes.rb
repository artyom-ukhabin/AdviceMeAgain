class CreateContentReviewVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :content_review_votes do |t|
      t.references :user, foreign_key: true
      t.references :content_review, foreign_key: true
      t.integer :vote
      t.timestamps

      t.index([:user_id, :content_review_id], unique: true, name: 'idx_crvotes_user_cr')
    end
  end
end
