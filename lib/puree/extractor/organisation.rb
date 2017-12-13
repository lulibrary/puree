module Puree

  module Extractor

    # Organisation extractor.
    #
    class Organisation < Puree::Extractor::Resource

      # @option (see Puree::Extractor::Resource#initialize)
      def initialize(config)
        super
      end

      # @param id [String]
      def find(id)
        find_and_extract id: id,
                         api_resource_type: :organisational_unit,
                         xml_extractor_resource_type: :organisation
      end

    end

  end

end
