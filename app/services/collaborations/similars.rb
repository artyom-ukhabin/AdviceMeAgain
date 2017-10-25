module Collaborations
  class Similars
    def initialize(items_type, rater)
      @similars_datastore_connector = Collaborations::DatastoreConnectors::SimilarsConnector.new
      @items_type = items_type
      @rater = rater
    end

    def update(user)
      highrated_items, lowrated_items =
        @rater.find_highrated_items(user), @rater.find_lowrated_items(user)
      related_users = @rater.find_users(highrated_items + lowrated_items) - [user]
      related_users.each do |other_user|
        update_cohesion(user, highrated_items, lowrated_items, other_user)
      end
    end

    def similars_for(user)
      @similars_datastore_connector.for_user_and_type(user, @items_type)
    end

    private

    def update_cohesion(user, highrated_items, lowrated_items, other_user)
      similarity_index = calculate_new_similarity(highrated_items, lowrated_items, other_user)
      update_datastore(user, other_user, similarity_index)
    end

    def update_datastore(user, other_user, similarity_index)
      @similars_datastore_connector.update(@items_type, user, other_user, similarity_index)
    end

    def calculate_new_similarity(highrated_items, lowrated_items, other_user)
      #Jaccard index
      #https://www.toptal.com/algorithms/predicting-likes-inside-a-simple-recommendation-engine
      #https://en.wikipedia.org/wiki/Jaccard_index
      highrated_items_ids, lowrated_items_ids = highrated_items.map(&:id), lowrated_items.map(&:id)
      other_highrated_items_ids, other_lowrated_items_ids =
        @rater.find_highrated_items_ids(other_user), @rater.find_lowrated_items_ids(other_user)
      (
        (highrated_items_ids & other_highrated_items_ids).length +
        (lowrated_items_ids & other_lowrated_items_ids).length -
        (highrated_items_ids & other_lowrated_items_ids).length -
        (lowrated_items_ids & other_highrated_items_ids).length
      ).fdiv((highrated_items_ids | lowrated_items_ids | other_highrated_items_ids | other_lowrated_items_ids).length)
    end

  end
end