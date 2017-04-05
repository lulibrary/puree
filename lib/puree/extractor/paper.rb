module Puree
  module Extractor

    # Paper extractor.
    #
    class Paper < Puree::Extractor::Publication

      # @option (see Puree::Extractor::Resource#initialize)
      def initialize(config)
        set_model_type 'paper'
        super
      end

      private

      def combine_metadata
        super

        @model.pages = @extractor.pages
        @model.page_range = @extractor.page_range
        @model.peer_reviewed = @extractor.peer_reviewed
        @model
      end

    end

  end
end
