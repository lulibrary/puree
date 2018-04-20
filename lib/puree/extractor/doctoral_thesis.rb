module Puree
  module Extractor

    # Doctoral thesis extractor.
    #
    class DoctoralThesis < Puree::Extractor::Thesis

      # @param id [String]
      # @return [Puree::Model::DoctoralThesis, nil]
      def find(id)
        find_and_extract id: id,
                         api_resource_type: :research_output,
                         xml_extractor_resource_type: :doctoral_thesis
      end

    end

  end
end
