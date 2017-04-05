module Puree
  module Extractor

    # Conference paper extractor.
    #
    class ConferencePaper < Puree::Extractor::PaperBase

      # @option (see Puree::Extractor::Resource#initialize)
      def initialize(config)
        set_model_type 'conference_paper'
        super
      end

      private

      def combine_metadata
        super

        @model.event = @extractor.event
        @model
      end

    end

  end
end