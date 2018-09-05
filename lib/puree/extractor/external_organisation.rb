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
      # @return [Fixnum]
      def count
        record_count :external_organisation
      end

      # Random record.
      #
      # @return [Puree::Model::ExternalOrganisation, nil]
      def random
        super :external_organisation
      end

    end

  end

end
