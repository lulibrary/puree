module Puree

  module Extractor

    # Publisher extractor.
    #
    class Publisher < Puree::Extractor::Resource

      # @param id [String]
      def find(id)
        find_and_extract id: id,
                         api_resource_type: :publisher,
                         xml_extractor_resource_type: :publisher
      end

      def count
        find_and_count :publisher
      end

    end

  end

end
