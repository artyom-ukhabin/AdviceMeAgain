module Elastic
  module ContentBased
    class PersonalityVector
      include Elastic::Concerns::Persistable

      attribute :content_type, String
      attribute :personality_id, Integer
      attribute :value, Hash[String, Float], mapping: { type: 'object' }

      class << self
        #TODO: for some reason update_attributes merges value_hash, instead of replacing it
        #TODO: so for now temporal solution to re-create vector. Investigate later.
        def create_or_update(params)
          personality_vector = find_by_content_type_and_id(params[:content_type], params[:personality_id]).first
          personality_vector.destroy if personality_vector
          self.create(params)
        end

        def find_by_content_type_and_id(content_type, personality_id)
          search(
            query: {
              bool: {
                must: [
                  { match: { content_type: content_type } },
                  { match: { personality_id: personality_id } }
                ]
              }
            }
          ).results
        end

        def find_by_content_type_and_multiply_ids(content_type, personality_ids)
          search(
            query: {
              bool: {
                must: [
                  { match: { content_type: content_type } },
                  { terms: { personality_id: personality_ids } }
                ]
              }
            }
          ).results
        end

        def find_by_type(content_type)
          search(
            query: {
              match: { content_type: content_type }
            }
          ).results
        end

        def find_vectors_by_id(personality_id)
          search(
            query: {
              match: { personality_id: personality_id }
            }
          ).results
        end

        def delete_by_id(personality_id)
          find_vectors_by_id(personality_id).each do |vector|
            vector.destroy
          end
        end
      end

      #TODO: nota bene
      def item_id
        personality_id
      end

      def [](key)
        value[key]
      end
    end
  end
end