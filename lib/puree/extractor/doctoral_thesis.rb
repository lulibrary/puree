module Puree
  module Extractor

    # Doctoral thesis extractor.
    #
    class DoctoralThesis < Puree::Extractor::Thesis

      # @option (see Puree::Extractor::Resource#initialize)
      def initialize(config)
        set_model_type 'doctoral_thesis'
        super
      end

      private

      def combine_metadata
        super
        @model.type === 'Doctoral Thesis' ? @model : nil
      end

    end

  end
end
