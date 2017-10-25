module ContentBasedFiltering
  module ItemImporters
    class ContentImporter
      def initialize
        @content_vector_object = VectorObjects::Content.new
      end

      def import
        Content.all.each { |content| @content_vector_object.update(content) }
      end
    end
  end
end