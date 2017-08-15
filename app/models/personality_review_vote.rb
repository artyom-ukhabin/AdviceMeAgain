class PersonalityReviewVote < ApplicationRecord
  belongs_to :user
  belongs_to :personality_review
end
