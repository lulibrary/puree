module Puree
  module Extractor

    # Doctoral thesis extractor.
    #
    class DoctoralThesis < Puree::Extractor::Thesis

      # @option (see Puree::Extractor::Resource#initialize)
      def initialize(config)
        super
      end

      # @param id [String]
      def find(id)
        find_and_extract id: id,
                         api_resource_type: :research_output,
                         xml_extractor_resource_type: :doctoral_thesis
      end

    end

  end
end
