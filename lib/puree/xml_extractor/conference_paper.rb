module Puree
  module XMLExtractor

    # Conference paper XML extractor.
    #
    class ConferencePaper < Puree::XMLExtractor::PaperBase
      include Puree::XMLExtractor::EventMixin

      def initialize(xml:)
        super
      end

    end
  end
end
