module Puree

  module XMLExtractor

    # Organisational unit mixin.
    #
    module OrganisationalUnitMixin

      # @return [Array<Puree::Model::OrganisationalUnitHeader>]
      def organisational_units
        xpath_result = xpath_query '/organisationalUnits/organisationalUnit'
        Puree::XMLExtractor::Shared.organisation_multi_header xpath_result
      end

    end

  end
end
