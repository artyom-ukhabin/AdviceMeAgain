module Elastic
  module Collaborative
    class UsersSimilarity
      include Elastic::Concerns::Persistable

      #TODO: maybe index on type + user_id

      attribute :type, String
      attribute :user_id, Integer
      attribute :similarity, Components::Similarity, mapping: { type: 'object' }

      #TODO: DSL
      class << self
        def create_or_update(params)
          users_similarity = find_by_user_and_type_and_other(params[:user_id], params[:type], params[:similarity][:user_id]).first
          users_similarity ? users_similarity.update_attributes(params) : self.create(params)
        end

        def find_by_user_and_type(user_id, type)
          search(
            query: {
              bool: {
                must: [
                  { match: { user_id: user_id} },
                  { match: { type: type } }
                ]
              }
            }
          ).results
        end

        def find_by_user_and_type_and_other(user_id, type, other_id)
          search(
            query: {
              bool: {
                must: [
                  { match: { user_id: user_id} },
                  { match: { type: type } },
                  { match: { 'similarity.user_id': other_id } }
                ]
              }
            }
          ).results
        end

        def similarities_for_user_and_type(user_id, type)
          find_by_user_and_type(user_id, type).map(&:similarity)
        end
      end

      def other_id
        similarity[:user_id]
      end

      def similarity_value
        similarity[:similarity]
      end
    end
  end
end