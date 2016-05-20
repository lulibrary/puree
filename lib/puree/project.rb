module Puree

  # Project resource
  #
  class Project < Resource

    def initialize
      super(:project)
    end

    # All metadata
    #
    # @return [Hash]
    def metadata
      super
    end

  end

end
