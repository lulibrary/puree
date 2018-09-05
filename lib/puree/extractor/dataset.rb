module Puree

  module Extractor

    # Dataset extractor.
    #
    class Dataset < Puree::Extractor::Resource

      # @param id [String]
      # @return [Puree::Model::Dataset, nil]
      def find(id)
        super id: id,
              api_resource_type: :dataset,
              xml_extractor_resource_type: :dataset
      end

      # Count of records available.
      #
      # @return [Fixnum]
      def count
        record_count :dataset
      end

      # Random record.
      #
      # @return [Puree::Model::Dataset, nil]
      def random
        super :dataset
      end

    end

  end

end