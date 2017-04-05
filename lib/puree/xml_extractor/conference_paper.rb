module Puree
  module XMLExtractor

    # Conference paper XML extractor.
    #
    class ConferencePaper < Puree::XMLExtractor::Publication
      include Puree::XMLExtractor::PagesMixin
      include Puree::XMLExtractor::PageRangeMixin
      include Puree::XMLExtractor::PeerReviewedMixin

      def initialize(xml:)
        super
      end

    end
  end
end
