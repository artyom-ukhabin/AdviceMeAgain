class Content < ApplicationRecord
  TYPES = %w(book movie game band)
  #TODO: think about not nil constraint or validation
  has_and_belongs_to_many :personalities
end
