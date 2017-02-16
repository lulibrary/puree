module Puree

  module Extractor

    class Journal < Resource

      # @param base_url [String]
      def initialize(base_url:)
        super
        setup :journal
      end

      private

      def combine_metadata
        super
        @model.issn = @extractor.issn
        @model.publisher = @extractor.publisher
        @model.title = @extractor.title
        @metadata = @model
      end

    end

  end

end
