class ContentRate < Base::Rate
  belongs_to :content
  scope :with_type, ->(content_type) { joins(:content).where('content.type = ?', content_type) }
end