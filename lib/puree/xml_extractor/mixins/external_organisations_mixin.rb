module Puree

  module XMLExtractor

    # External organisations extractor mixin.
    #
    module ExternalOrganisationsMixin

      # @return [Array<Puree::Model::ExternalOrganisationHeader>]
      def external_organisations
        xpath_result = xpath_query '/associatedExternalOrganisations/externalOrganisation'
        Puree::XMLExtractor::Shared.external_organisation_multi_header xpath_result
      end

    end

  end
end
