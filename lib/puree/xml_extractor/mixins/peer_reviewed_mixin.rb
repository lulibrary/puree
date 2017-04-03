module Puree

  module XMLExtractor

    # Peer reviewed extractor mixin.
    #
    module PeerReviewedMixin

      # @return [Boolean, nil]
      def peer_reviewed
        xpath_result = xpath_query_for_single_value('/peerReview/peerReviewed')
        return true if xpath_result === 'true'
        return false if xpath_result === 'false'
        nil
      end

    end

  end
end
