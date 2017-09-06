module Elastic
  module Concerns
    module Persistable
      extend ActiveSupport::Concern

      included do
        include Elasticsearch::Persistence::Model

        index_name [Rails.application.engine_name, Rails.env].join('-') #TODO: check

        after_create lambda { self.class.refresh_index!  }
        after_update lambda { self.class.refresh_index! }
        after_destroy lambda { self.class.refresh_index! }
      end
    end
  end
end