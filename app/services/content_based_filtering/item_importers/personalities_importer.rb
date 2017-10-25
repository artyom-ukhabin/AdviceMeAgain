module ContentBasedFiltering
  module ItemImporters
    class PersonalitiesImporter
      def initialize
        @personality_vector_object = VectorObjects::Personality.new
      end

      def import
        Personality.all.each { |personality| @personality_vector_object.update(personality) }
      end
    end
  end
end