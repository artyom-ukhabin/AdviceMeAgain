class BandGenre < Base::ContentGenre
  #TODO: maybe call this content in future and implement content method in parent
  has_and_belongs_to_many :content, class_name: 'Band', association_foreign_key: 'content_id'
end
