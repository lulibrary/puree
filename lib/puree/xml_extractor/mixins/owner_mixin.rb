module Puree

  module XMLExtractor

    # Owner mixin.
    #
    module OwnerMixin

      # @return [Puree::Model::OrganisationHeader, nil]
      def owner
        xpath_result = xpath_query '/managingOrganisationalUnit'
        Puree::XMLExtractor::Shared.organisation_header xpath_result
      end

    end

  end
end
