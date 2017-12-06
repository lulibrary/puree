module Puree
  module Extractor

    # Conference paper extractor.
    #
    class ConferencePaper < Puree::Extractor::PaperBase

      # @option (see Puree::Extractor::Resource#initialize)
      def initialize(config)
        super
        setup_model 'conference_paper'
      end

      private

      def combine_metadata
        super

        @model.event = event
        @model
      end

    end

  end
end
