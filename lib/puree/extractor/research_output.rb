module Puree

  module Extractor

    # Research output extractor.
    #
    class ResearchOutput < Puree::Extractor::Resource

      # @param id [String]
      def find(id)
        find_and_extract id: id,
                         api_resource_type: :research_output,
                         xml_extractor_resource_type: :research_output
      end

    end

  end

end
