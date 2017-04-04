#TODO: fix create ability from the outside
module ContentDataCollectors
  class DefaultContentDataCollector
    def collect(content)
      collection = {}
      collection[:content] = content
      collection
    end
  end
end