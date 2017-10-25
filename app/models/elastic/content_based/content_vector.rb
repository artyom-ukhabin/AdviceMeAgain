module Elastic
  module ContentBased
    class ContentVector
      include Elastic::Concerns::Persistable

      attribute :content_type, String
      attribute :content_id, Integer
      attribute :value, Hash[String, Float], strict: true, mapping: { type: 'object' }

      class << self
        #TODO: for some reason update_attributes merges value_hash, instead of replacing it
        #TODO: so for now temporal solution to re-create vector. Investigate later.
        def create_or_update(params)
          content_vector = find_by_type_and_id(params[:content_type], params[:content_id]).first
          content_vector.destroy if content_vector
          self.create(params)
        end

        def find_by_type_and_id(content_type, content_id)
          search(
            query: {
              bool: {
                must: [
                  { match: { content_type: content_type } },
                  { match: { content_id: content_id } }
                ]
              }
            }
          ).results
        end

        def find_by_type_and_multiply_ids(content_type, content_ids)
          search(
            query: {
              bool: {
                must: [
                  { match: { content_type: content_type } },
                  { terms: { content_id: content_ids } }
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

        def find_by_id(content_id)
          search(
            query: {
              match: { content_id: content_id }
            }
          ).results
        end

        def delete_by_id(content_id)
          content_vector = find_by_id(content_id).first
          content_vector.destroy if content_vector
        end
      end

      def item_id
        content_id
      end

      def [](key)
        value[key]
      end
    end
  end
end