module Puree

  module XMLExtractor

    # Person XML extractor.
    #
    class Person < Puree::XMLExtractor::Resource
      include Puree::XMLExtractor::KeywordMixin

      def initialize(xml:)
        super
        @resource_type = :person
      end

      # @return [Array<Puree::Model::OrganisationHeader>]
      def affiliations
        xpath_result = xpath_query '/staffOrganisationAssociations/staffOrganisationAssociation/organisationalUnit'
        Puree::XMLExtractor::Shared.organisation_multi_header xpath_result if xpath_result
      end

      # @return [Array<String>]
      def email_addresses
        xpath_query_for_multi_value '/staffOrganisationAssociations/staffOrganisationAssociation/emails/email'
      end

      # @return [String, nil]
      def employee_id
        xpath_query_for_single_value '/ids/id[@type="Employee ID"]'
      end

      # @return [String, nil]
      def hesa_id
        xpath_query_for_single_value '/ids/id[@type="HESA staff ID"]'
      end

      # @return [Array<String>]
      def image_urls
        xpath_query_for_multi_value '/profilePhotos/profilePhoto[@url]'
      end

      # @return [Array<String>]
      def keywords
        keyword_group 'userDefinedKeywordContainers'
      end

      # @return [Puree::Model::PersonName, nil]
      def name
        xpath_result = xpath_query '/name'
        if xpath_result
          first = xpath_result.xpath('firstName').text.strip
          last = xpath_result.xpath('lastName').text.strip
          model = Puree::Model::PersonName.new
          model.first = first unless first.empty?
          model.last = last unless last.empty?
          model
        end
      end

      # @return [String, nil]
      def orcid
        xpath_query_for_single_value '/orcid'
      end

      # @return [String, nil]
      def scopus_id
        xpath_query_for_single_value '/ids/id[@type="Scopus author ID"]'
      end

      private

      def xpath_root
        '/person'
      end

    end

  end

end