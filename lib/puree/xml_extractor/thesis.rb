module Puree
  module XMLExtractor

    # Thesis XML extractor.
    #
    class Thesis < Puree::XMLExtractor::Publication
      include Puree::XMLExtractor::DoiMixin
      include Puree::XMLExtractor::PagesMixin

      def initialize(xml:)
        super
      end

      # @return [Time, nil]
      def award_date
        xpath_result = xpath_query_for_single_value('/awardDate')
        Time.parse xpath_result if xpath_result
      end

      # @return [Puree::Model::OrganisationHeader, nil]
      def awarding_institution
        xpath_result = xpath_query '/awardingInstitution/internalExternalOrganisationAssociation/organisation'
        Puree::XMLExtractor::Shared.organisation_header xpath_result
      end

      # @return [String, nil]
      def qualification
        types = {
            '/dk/atira/pure/thesis/qualification/mphil' => 'MPhil',
            '/dk/atira/pure/thesis/qualification/phd' => 'PhD',
            '/dk/atira/pure/thesis/qualification/masters_by_research' => 'Masters by Research'
        }
        xpath_result = xpath_query_for_single_value '/qualification/uri'
        types[xpath_result]
      end

      # @return [Array<String>]
      def sponsors
        xpath_query_for_multi_value '/sponsors/externalOrganisation/name'
      end

    end
  end
end
