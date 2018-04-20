module Puree

  module Extractor

    # Publisher extractor.
    #
    class Publisher < Puree::Extractor::Resource

      # @param id [String]
      # @return [Puree::Model::Publisher, nil]
      def find(id)
        find_and_extract id: id,
                         api_resource_type: :publisher,
                         xml_extractor_resource_type: :publisher
      end

      # Count of records available.
      #
      # @return [Fixnum]
      def count
        find_and_extract_count :publisher
      end

    end

  end

end
