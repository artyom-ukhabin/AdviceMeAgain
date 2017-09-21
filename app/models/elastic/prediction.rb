module Elastic
  class Prediction
    include Virtus.model

    attribute :item_id, Integer
    attribute :prediction, Float
  end
end