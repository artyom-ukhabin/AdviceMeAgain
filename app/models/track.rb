class Track < ApplicationRecord
  self.table_name = 'tracks'
  belongs_to :album
end
