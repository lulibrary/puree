module Puree

  module Extractor

    # Publisher extractor.
    #
    class Publisher < Puree::Extractor::Resource

      # @param id [String]
      # @return [Puree::Model::Publisher, nil]
      def find(id)
        super id: id,
              api_resource_type: :publisher,
              xml_extractor_resource_type: :publisher
      end

      # Count of records available.
      #
      # @return [Fixnum]
      def count
        record_count :publisher
      end

      # Random record.
      #
      # @return [Puree::Model::Publisher, nil]
      def random
        super :publisher
      end

    end

  end

end
