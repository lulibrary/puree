module Puree

  module Extractor

    # External organisation extractor.
    #
    class ExternalOrganisation < Puree::Extractor::Resource

      # @param id [String]
      # @return [Puree::Model::ExternalOrganisation, nil]
      def find(id)
        super id: id,
              api_resource_type: :external_organisation,
              xml_extractor_resource_type: :external_organisation
      end

      # Count of records available.
      #
      # @param params [Hash] Combined GET and POST parameters for all records
      # @return [Integer]
      def count(params = {})
        record_count :external_organisation, params
      end

      # Random record.
      #
      # @param params [Hash] Combined GET and POST parameters for all records
      # @return [Puree::Model::ExternalOrganisation, nil]
      def random(params = {})
        super :external_organisation, params
      end

    end

  end

end
