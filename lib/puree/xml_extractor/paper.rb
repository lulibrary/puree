module Puree
  module XMLExtractor

    # Paper XML extractor.
    #
    class Paper < Puree::XMLExtractor::PaperBase

      def initialize(xml:)
        super
      end

      private

      def xpath_root
        '/contributionToConference'
      end

    end
  end
end
