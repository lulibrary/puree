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
      # @param params [Hash] Combined GET and POST parameters for all records
      # @return [Fixnum]
      def count(params = {})
        record_count :dataset, params
      end

      # Random record.
      #
      # @param params [Hash] Combined GET and POST parameters for all records
      # @return [Puree::Model::Dataset, nil]
      def random(params = {})
        super :dataset, params
      end

    end

  end

end