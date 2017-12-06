module Puree
  module Extractor

    # Paper extractor.
    #
    class Paper < Puree::Extractor::PaperBase

      # @option (see Puree::Extractor::Resource#initialize)
      def initialize(config)
        super
        setup_model 'paper'
      end

      private

      def combine_metadata
        super
      end

    end

  end
end
