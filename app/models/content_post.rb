class ContentPost < ApplicationRecord
  #TODO: apply constraint for uniq content_id-post_id

  FIRST_POSITION = 1

  belongs_to :content
  belongs_to :post

  scope :ordered_by_position, -> { order :position }
  scope :group_by_sections, -> { includes(:content) }
end
