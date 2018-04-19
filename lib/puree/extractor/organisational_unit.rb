module Puree

  module Extractor

    # Organisational unit extractor.
    #
    class OrganisationalUnit < Puree::Extractor::Resource

      # @option (see Puree::Extractor::Resource#initialize)
      def initialize(config)
        super
      end

      # @param id [String]
      def find(id)
        find_and_extract id: id,
                         api_resource_type: :organisational_unit,
                         xml_extractor_resource_type: :organisational_unit
      end

      def count
        find_and_count :organisational_unit
      end

    end

  end

end
