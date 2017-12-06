module Puree
  module Model

    # A conference paper.
    #
    class ConferencePaper < Puree::Model::Paper

      # @return [Puree::Model::EventHeader, nil]
      attr_accessor :event

    end
  end
end