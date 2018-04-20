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
      # @return [Fixnum]
      def count
        record_count :organisational_unit
      end

      # Random record.
      #
      # @return [Puree::Model::OrganisationalUnit, nil]
      def random
        super :organisational_unit
      end

    end

  end

end
