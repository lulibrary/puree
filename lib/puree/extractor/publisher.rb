module Puree

  module Extractor

    class Publisher < Resource

      # @param base_url [String]
      def initialize(base_url:)
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
