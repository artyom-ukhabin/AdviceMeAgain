module Base
  class ContentGenre < ApplicationRecord
    self.abstract_class = true

    scope :without_content, ->(content) { where.not(id: content.genre_ids) }
    scope :with_name, ->(name) { where("name like ?", "%#{name}%") }
    scope :ordered_by_name, -> { order(:name) }
    scope :ordered_availables_for_content, ->(content) { without_content(content).ordered_by_name }

    class << self
      #TODO: think
      def token_inputs_for_content(term, content)
        ordered_availables_for_content(content).with_name(term)
      end

      def content
        raise NotImplementedError
      end
    end

    #TODO: do something with this
    def content_type
      self.class.name.split(/Genre/, 2).first
    end
  end
end
