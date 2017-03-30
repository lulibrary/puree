module Puree
  module Extractor

    # Master's thesis extractor.
    #
    class MastersThesis < Puree::Extractor::Thesis

      # @option (see Puree::Extractor::Resource#initialize)
      def initialize(config)
        set_model_type 'masters_thesis'
        super
      end

    end

  end
end
