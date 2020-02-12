module Puree

  module XMLExtractor

    # Person XML extractor.
    #
    class Person < Puree::XMLExtractor::Resource
      include Puree::XMLExtractor::IdentifierMixin
      include Puree::XMLExtractor::KeywordMixin

      def initialize(xml)
        super
        setup_model :person
      end

      # @return [Array<Puree::Model::OrganisationalUnitHeader>]
      def affiliations
        xpath_result = xpath_query '/staffOrganisationAssociations/staffOrganisationAssociation/organisationalUnit'
        Puree::XMLExtractor::Shared.organisation_multi_header xpath_result if xpath_result
      end

      # @return [Array<String>]
      def email_addresses
        xpath_query_for_multi_value '/staffOrganisationAssociations/staffOrganisationAssociation/emails/email'
      end

      # @return [Array<String>]
      def image_urls
        xpath_result = xpath_query '/profilePhotos/profilePhoto'
        arr = []
        xpath_result.each do |i|
          arr << i.xpath('url').text.strip
        end
        arr.uniq
      end

      # @return [Array<String>]
      def keywords
        keyword_group 'keywordContainers'
      end

      # @return [Puree::Model::PersonName, nil]
      def name
        xpath_result = xpath_query '/name'
        if !xpath_result.empty?
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

      # @return [Array<Model::PersonName>]
      def other_names
        xpath_result = xpath_query '/nameVariants/nameVariant/name'
        data = []
        xpath_result.each do |d|
          first = xpath_result.xpath('firstName').text.strip
          last = xpath_result.xpath('lastName').text.strip
          model = Puree::Model::PersonName.new
          model.first = first unless first.empty?
          model.last = last unless last.empty?
          data << model
        end
        data.uniq
      end

      private

      def xpath_root
        '/person'
      end

      def combine_metadata
        super
        @model.affiliations = affiliations
        @model.email_addresses = email_addresses
        @model.identifiers = identifiers
        @model.image_urls = image_urls
        @model.keywords = keywords
        @model.name = name
        @model.orcid = orcid
        @model.other_names = other_names
        @model
      end      

    end

  end

end