module Decorable
  def initialize_hash(decorable)
    decorated_decorable = {}
    decorated_decorable[:subject] = decorable
    decorated_decorable
  end
end