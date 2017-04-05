module Puree
  module XMLExtractor

    # Paper XML extractor.
    #
    class Paper < Puree::XMLExtractor::Publication
      include Puree::XMLExtractor::PagesMixin
      include Puree::XMLExtractor::PageRangeMixin
      include Puree::XMLExtractor::PeerReviewedMixin

      def initialize(xml:)
        super
      end

    end
  end
end
