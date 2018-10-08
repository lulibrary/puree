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
      # @param params [Hash] Combined GET and POST parameters for all records
      # @return [Fixnum]
      def count(params = {})
        record_count :journal, params
      end

      # Random record.
      #
      # @param params [Hash] Combined GET and POST parameters for all records
      # @return [Puree::Model::Journal, nil]
      def random(params = {})
        super :journal, params
      end

    end

  end

end
