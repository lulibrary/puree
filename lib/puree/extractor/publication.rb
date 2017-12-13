module Puree

  module Extractor

    # Publication extractor.
    #
    class Publication < Puree::Extractor::Resource

      # @param id [String]
      def find(id)
        find_and_extract id: id,
                         api_resource_type: :research_output,
                         xml_extractor_resource_type: :publication
      end

    end

  end

end
