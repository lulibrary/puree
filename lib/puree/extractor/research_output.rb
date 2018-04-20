module Puree

  module Extractor

    # Research output extractor.
    #
    class ResearchOutput < Puree::Extractor::Resource

      # @param id [String]
      # @return [Puree::Model::ResearchOutput, nil]
      def find(id)
        find_and_extract id: id,
                         api_resource_type: :research_output,
                         xml_extractor_resource_type: :research_output
      end

      # Count of records available.
      #
      # @return [Fixnum]
      def count
        find_and_extract_count :research_output
      end

    end

  end

end
