module Puree
  module XMLExtractor

    # Conference paper XML extractor.
    #
    class ConferencePaper < Puree::XMLExtractor::Paper
      include Puree::XMLExtractor::EventMixin

      def initialize(xml)
        super
        setup_model :conference_paper
      end

      private

      def xpath_root
        '/contributionToConference'
      end

    end
  end
end
