module Elastic
  module Components
    class Similarity
      include Virtus.model

      attribute :user_id, Integer
      attribute :similarity, Float
    end
  end
end
