module Puree
  module Extractor

    # Master's thesis extractor.
    #
    class MastersThesis < Puree::Extractor::Thesis

      # @option (see Puree::Extractor::Resource#initialize)
      def initialize(config)
        super
      end

      # @param id [String]
      def find(id)
        find_and_extract id: id,
                         api_resource_type: :thesis,
                         xml_extractor_resource_type: :masters_thesis
      end

    end

  end
end
