module Puree

  module Extractor

    # Journal extractor.
    #
    class Journal < Puree::Extractor::Resource

      # @param id [String]
      # @return [Puree::Model::Journal, nil]
      def find(id)
        super id: id,
              api_resource_type: :journal,
              xml_extractor_resource_type: :journal
      end

      # Count of records available.
      #
      # @return [Fixnum]
      def count
        record_count :journal
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
