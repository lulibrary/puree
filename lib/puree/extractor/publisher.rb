module Puree

  module Extractor

    # Publisher extractor
    #
    class Publisher < Puree::Extractor::Resource

      # @param url [String]
      def initialize(url:)
        super
        setup :publisher
      end

      private

      def combine_metadata
        super
        @model.name = @extractor.name
        @model
      end

    end

  end

end
