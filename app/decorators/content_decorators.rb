module ContentDecorators
  class << self
    def data_for_index_action(content, user)
      handler = case content
        when Game then ContentDecorators::GameDecorator.new
        else ContentDecorators::BaseDecorator.new
      end
      handler.for_index_action(content, user)
    end

    def data_for_show_action(content, user)
      handler = case content
        when Band then ContentDecorators::BandDecorator.new
        when Game then ContentDecorators::GameDecorator.new
        else ContentDecorators::BaseDecorator.new
      end
      handler.for_show_action(content, user)
    end
  end
end