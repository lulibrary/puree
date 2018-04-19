module Puree

  module Extractor

    # Journal extractor.
    #
    class Journal < Puree::Extractor::Resource

      # @param id [String]
      def find(id)
        find_and_extract id: id,
                         api_resource_type: :journal,
                         xml_extractor_resource_type: :journal
      end

      def count
        find_and_count :journal
      end

    end

  end

end
