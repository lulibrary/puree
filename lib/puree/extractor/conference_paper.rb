module Puree
  module Extractor

    # Conference paper extractor.
    #
    class ConferencePaper < Puree::Extractor::Publication

      # @option (see Puree::Extractor::Resource#initialize)
      def initialize(config)
        set_model_type 'conference_paper'
        super
      end

      private

      def combine_metadata
        super

        @model.bibliographical_note = @extractor.bibliographical_note
        @model.pages = @extractor.pages
        @model.page_range = @extractor.page_range
        @model.peer_reviewed = @extractor.peer_reviewed
        @model
      end

    end

  end
end
