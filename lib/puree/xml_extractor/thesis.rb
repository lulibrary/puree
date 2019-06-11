module Puree
  module XMLExtractor

    # Thesis XML extractor.
    #
    class Thesis < Puree::XMLExtractor::ResearchOutput
      include Puree::XMLExtractor::DoiMixin
      include Puree::XMLExtractor::PagesMixin
      include Puree::XMLExtractor::PublisherMixin

      def initialize(xml)
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
        xpath_query_for_single_value('/qualifications/qualification')
      end

      # @return [Array<Puree::Model::ExternalOrganisationHeader>]
      def sponsors
        xpath_result = xpath_query '/sponsors/sponsor'
        Puree::XMLExtractor::Shared.external_organisation_multi_header xpath_result if xpath_result
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
        @model.publisher = publisher
        @model.qualification = qualification
        @model.sponsors = sponsors
        @model      
      end
    end
  end
end
