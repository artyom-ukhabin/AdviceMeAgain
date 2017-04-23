module ContentDecorators
  class ContentDecorator
    #TODO: refactor this classes, inheritance or some <<< HIGH PRIORITY
    #TODO: write more flexible code, with constructor maybe
    class << self
      def for_index_action(content, user)
        handler = case content
          when Game then ContentDecorators::GameDecorator.new
          else ContentDecorators::DefaultContentDecorator.new
        end
        handler.decorate(content, user)
      end

      def for_show_action(content, user)
        handler = case content
          when Band then ContentDecorators::BandDecorator.new
          when Game then ContentDecorators::GameDecorator.new
          else ContentDecorators::DefaultContentDecorator.new
        end
        handler.decorate(content, user)
      end
    end
  end
end