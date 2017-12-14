module Puree
  module Extractor

    # Paper extractor.
    #
    class Paper < Puree::Extractor::ResearchOutput

      # @param id [String]
      def find(id)
        find_and_extract id: id,
                         api_resource_type: :research_output,
                         xml_extractor_resource_type: :paper
      end

    end

  end
end
