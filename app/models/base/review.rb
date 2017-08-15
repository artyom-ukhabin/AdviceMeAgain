module Base
  class Review < ApplicationRecord
    include Voteable

    self.abstract_class = true

    belongs_to :user

    validates_presence_of :body

    def author_profile
      user.profile
    end

    private

    #TODO: get rid of dependency
    def voted_users
      raise NotImplementedError
    end

    def users_with_vote(vote)
      raise NotImplementedError
    end

    def upvoted_users
      raise NotImplementedError
    end

    def downvoted_users
      raise NotImplementedError
    end
  end
end