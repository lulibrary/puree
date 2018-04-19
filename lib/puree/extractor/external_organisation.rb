module Puree

  module Extractor

    # External organisation extractor.
    #
    class ExternalOrganisation < Puree::Extractor::Resource

      # @param id [String]
      def find(id)
        find_and_extract id: id,
                         api_resource_type: :external_organisation,
                         xml_extractor_resource_type: :external_organisation
      end

      def count
        find_and_count :external_organisation
      end

    end

  end

end
