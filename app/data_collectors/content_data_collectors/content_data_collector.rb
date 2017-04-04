module ContentDataCollectors
  class ContentDataCollector
    def initialize(content)
      @content = content
      @handler = case content
        when Band then BandDataCollector.new
        when Game then GameDataCollector.new
        else DefaultContentDataCollector.new
      end
    end

    def collect
      @handler.collect(@content)
    end
  end
end
