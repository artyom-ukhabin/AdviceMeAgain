class ContentReviewVote < ApplicationRecord
  belongs_to :user
  belongs_to :content_review
end
