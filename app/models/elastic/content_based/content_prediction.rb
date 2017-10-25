module Elastic
  module ContentBased
    class ContentPrediction
      include Elastic::Concerns::Persistable

      #TODO: maybe index on type + user_id
      #TODO: elastic means ton of code for consistency

      attribute :type, String
      attribute :user_id, Integer
      attribute :prediction, Components::Prediction, mapping: { type: 'object' }

      #TODO: DSL
      class << self
        def create_or_update(params)
          user_item_prediction = find_by_user_and_type_and_item(params[:user_id], params[:type], params[:prediction][:item_id]).first
          user_item_prediction ? user_item_prediction.update_attributes(params) : self.create(params)
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

        def find_by_user_and_type_and_item(user_id, type, item_id)
          search(
            query: {
              bool: {
                must: [
                  { match: { user_id: user_id} },
                  { match: { type: type } },
                  { match: { 'prediction.item_id': item_id} }
                ]
              }
            }
          ).results
        end

        def find_by_user(user_id)
          search(
            query: {
              match: { user_id: user_id }
            }
          ).results
        end

        def predictions_for_user_and_type(user_id, type)
          find_by_user_and_type(user_id, type).map(&:prediction)
        end

        def delete_by_user_and_type(user_id, type)
          find_by_user_and_type(user_id, type).each do |recommendation|
            recommendation.destroy
          end
        end

        def delete_by_user(user_id)
          find_by_user(user_id).each do |recommendation|
            recommendation.destroy
          end
        end
      end

      def item_id
        prediction[:item_id]
      end

      def prediction_value
        prediction[:prediction]
      end
    end
  end
end