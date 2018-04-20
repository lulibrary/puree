module Puree

  module Extractor

    # Journal extractor.
    #
    class Journal < Puree::Extractor::Resource

      # @param id [String]
      # @return [Puree::Model::Journal, nil]
      def find(id)
        find_and_extract id: id,
                         api_resource_type: :journal,
                         xml_extractor_resource_type: :journal
      end

      # Count of records available.
      #
      # @return [Fixnum]
      def count
        find_and_extract_count :journal
      end

      # Random record.
      #
      # @return [Puree::Model::Journal, nil]
      def random
        super :journal
      end

    end

  end

end
