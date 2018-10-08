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
      # @param params [Hash] Combined GET and POST parameters for all records
      # @return [Fixnum]
      def count(params = {})
        record_count :publisher, params
      end

      # Random record.
      #
      # @param params [Hash] Combined GET and POST parameters for all records
      # @return [Puree::Model::Publisher, nil]
      def random(params = {})
        super :publisher, params
      end

    end

  end

end
