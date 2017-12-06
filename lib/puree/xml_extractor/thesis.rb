module Puree
  module XMLExtractor

    # Thesis XML extractor.
    #
    class Thesis < Puree::XMLExtractor::Publication
      include Puree::XMLExtractor::DoiMixin
      include Puree::XMLExtractor::PagesMixin

      def initialize(xml:)
        super
        setup_model :thesis
      end

      # @return [Time, nil]
      def award_date
        xpath_result = xpath_query_for_single_value('/awardedDate')
        Time.parse xpath_result if xpath_result
      end

      # @return [Puree::Model::ExternalOrganisationHeader, nil]
      def awarding_institution
        xpath_result = xpath_query '/awardingInstitutions/awardingInstitution/externalOrganisationalUnit'
        Puree::XMLExtractor::Shared.external_organisation_header xpath_result if xpath_result
      end

      # @return [String, nil]
      def qualification
        xpath_query_for_single_value '/qualification'
      end

      # @return [Array<String>]
      def sponsors
        xpath_query_for_multi_value '/sponsors/sponsor/name'
      end

      private

      def xpath_root
        '/thesis'
      end

      def combine_metadata
        super
        @model.award_date = award_date
        @model.awarding_institution = awarding_institution
        @model.doi = doi
        @model.pages = pages
        @model.qualification = qualification
        @model.sponsors = sponsors
        @model      
      end
    end
  end
end
