module Puree
  module Extractor

    # Conference paper extractor.
    #
    class ConferencePaper < Puree::Extractor::Resource

      # @param id [String]
      # @return [Puree::Model::ConferencePaper, nil]
      def find(id)
        super id: id,
              api_resource_type: :research_output,
              xml_extractor_resource_type: :conference_paper
      end

    end

  end
end
