module Elastic
  module ContentBased
    class UserContentPreferenceVector
      include Elastic::Concerns::Persistable

      attribute :user_id, Integer
      attribute :content_type, String
      attribute :value, Hash[String, Float], mapping: { type: 'object' }

      class << self
        def create_or_update(params)
          user_vector = find_by_type_and_id(params[:content_type], params[:user_id]).first
          user_vector ? user_vector.update_attributes(params) : self.create(params)
        end

        def find_by_type_and_id(content_type, user_id)
          search(
            query: {
              bool: {
                must: [
                  { match: { content_type: content_type } },
                  { match: { user_id: user_id } }
                ]
              }
            }
          ).results
        end

        def find_vectors_by_id(user_id)
          search(
            query: {
              match: { user_id: user_id }
            }
          ).results
        end

        def delete_by_id(user_id)
          find_vectors_by_id(user_id).each do |vector|
            vector.destroy
          end
        end
      end

      def [](key)
        value[key]
      end
    end
  end
end