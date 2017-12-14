module Puree
  module XMLExtractor

    # Paper base XML extractor.
    #
    class Paper < Puree::XMLExtractor::ResearchOutput
      include Puree::XMLExtractor::PagesMixin
      include Puree::XMLExtractor::PageRangeMixin
      include Puree::XMLExtractor::PeerReviewedMixin

      def initialize(xml)
        super
        setup_model :paper
      end

      private

      def combine_metadata
        super
        @model.pages = pages
        @model.page_range = page_range
        @model.peer_reviewed = peer_reviewed
        @model
      end      

    end
  end
end
