module Puree

  # Journal resource
  #
  class Journal < Resource

    def initialize
      super(:journal)
    end

    # All metadata
    #
    # @return [Hash]
    def metadata
      super
    end

  end

end
