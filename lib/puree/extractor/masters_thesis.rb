module Puree
  module Extractor

    # Master's thesis extractor.
    #
    class MastersThesis < Puree::Extractor::Resource

      # @param id [String]
      # @return [Puree::Model::MastersThesis, nil]
      def find(id)
        super id: id,
              api_resource_type: :research_output,
              xml_extractor_resource_type: :masters_thesis
      end

    end

  end
end
