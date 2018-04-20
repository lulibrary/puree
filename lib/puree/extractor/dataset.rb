module Puree

  module Extractor

    # Dataset extractor.
    #
    class Dataset < Puree::Extractor::Resource

      # @param id [String]
      def find(id)
        find_and_extract id: id,
                         api_resource_type: :dataset,
                         xml_extractor_resource_type: :dataset
      end

      # Count of records available.
      #
      # @return [Fixnum]
      def count
        find_and_extract_count :dataset
      end

    end

  end

end