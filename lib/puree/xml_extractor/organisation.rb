module Puree

  module XMLExtractor

    # Organisation XML extractor.
    #
    class Organisation < Puree::XMLExtractor::Resource

      def initialize(xml:)
        super
        @resource_type = :organisation
      end

      # @return [Array<Puree::Model::Address>]
      def address
        xpath_result = xpath_query '/addresses/classifiedAddress'
        data = []
        xpath_result.each do |d|
          a = Puree::Model::Address.new
          street = d.xpath('street').text.strip
          a.street = street unless street.empty?
          building = d.xpath('building').text.strip
          a.building = building unless building.empty?
          postcode = d.xpath('postalCode').text.strip
          a.postcode = postcode unless building.empty?
          city = d.xpath('city').text.strip
          a.city = city unless city.empty?
          country = d.xpath('country/term/localizedString').text.strip
          a.country = country unless country.empty?
          data << a
        end
        data.uniq
      end

      # @return [Array<String>]
      def email_addresses
        xpath_query_for_multi_value '/emails/classificationDefinedStringFieldExtension/value'
      end

      # @return [String, nil]
      def name
        xpath_query_for_single_value '/name/localizedString'
      end

      # @return [Array<Puree::Model::OrganisationHeader>]
      def organisations
        xpath_result = xpath_query '/organisations/organisation'
        Puree::XMLExtractor::Shared.organisation_multi_header xpath_result
      end

      # @return [Puree::Model::OrganisationHeader, nil]
      def parent
        organisations.first unless organisations.empty?
      end

      # @return [Array<String>]
      def phone_numbers
        xpath_query_for_multi_value '/phoneNumbers/classificationDefinedStringFieldExtension/value'
      end

      # @return [String, nil]
      def type
        xpath_query_for_single_value '/typeClassification/term/localizedString'
      end

      # @return [Array<String>]
      def urls
        xpath_query_for_multi_value '/webAddresses/classificationDefinedFieldExtension/value/localizedString'
      end

    end

  end

end