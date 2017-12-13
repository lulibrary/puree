module Puree
  module Extractor

    # Conference paper extractor.
    #
    class ConferencePaper < Puree::Extractor::Paper

      # @param id [String]
      def find(id)
        find_and_extract id: id,
                         api_resource_type: :research_output,
                         xml_extractor_resource_type: :conference_paper
      end

    end

  end
end
