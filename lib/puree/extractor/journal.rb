module Puree

  module Extractor

    class Journal < Puree::Extractor::Resource

      # @param url [String]
      def initialize(url:)
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
