module Puree

  module Extractor

    # Organisational unit extractor.
    #
    class OrganisationalUnit < Puree::Extractor::Resource

      # @param id [String]
      # @return [Puree::Model::OrganisationalUnit, nil]
      def find(id)
        super id: id,
              api_resource_type: :organisational_unit,
              xml_extractor_resource_type: :organisational_unit
      end

      # Count of records available.
      #
      # @param params [Hash] Combined GET and POST parameters for all records
      # @return [Fixnum]
      def count(params = {})
        record_count :organisational_unit, params
      end

      # Random record.
      #
      # @param params [Hash] Combined GET and POST parameters for all records
      # @return [Puree::Model::OrganisationalUnit, nil]
      def random(params = {})
        super :organisational_unit, params
      end

    end

  end

end
