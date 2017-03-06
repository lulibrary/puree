module Puree

  module Extractor

    # Journal extractor.
    #
    class Journal < Puree::Extractor::Resource

      # @option (see Puree::Extractor::Resource#initialize)
      def initialize(config)
        super
        setup :journal
      end

      private

      def combine_metadata
        super
        @model.issn = @extractor.issn
        @model.publisher = @extractor.publisher
        @model.title = @extractor.title
        @model
      end

    end

  end

end
