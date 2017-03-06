module Puree

  module Extractor

    # Publisher extractor.
    #
    class Publisher < Puree::Extractor::Resource

      # @option (see Puree::Extractor::Resource#initialize)
      def initialize(config)
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
