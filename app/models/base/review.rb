module Base
  class Review < ApplicationRecord
    self.abstract_class = true

    belongs_to :user
    validates_presence_of :body


    def author_profile
      user.profile
    end
  end
end