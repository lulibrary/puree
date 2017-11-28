module Puree

  module XMLExtractor

    # Organisation mixin.
    #
    module OrganisationMixin

      # @return [Array<Puree::Model::OrganisationHeader>]
      def organisations
        xpath_result = xpath_query '/organisationalUnits/organisationalUnit'
        Puree::XMLExtractor::Shared.organisation_multi_header xpath_result
      end

    end

  end
end
