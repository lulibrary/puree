module Puree
  module Extractor

    # Thesis extractor.
    #
    class Thesis < Puree::Extractor::Resource

      # @param id [String]
      # @return [Puree::Model::Thesis, nil]
      def find(id)
        find_and_extract id: id,
                         api_resource_type: :research_output,
                         xml_extractor_resource_type: :thesis
      end

    end

  end
end
