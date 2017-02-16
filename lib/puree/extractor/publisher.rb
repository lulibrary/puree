module Puree

  module Extractor

    class Publisher < Resource

      # @param url [String]
      def initialize(url:)
        super
        setup :publisher
      end

      private

      def combine_metadata
        super
        @model.name = @extractor.name
        @metadata = @model
      end

    end

  end

end
