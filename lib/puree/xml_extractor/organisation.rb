module Puree

  module XMLExtractor

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
          street = d.xpath('street').text.strip
          building = d.xpath('building').text.strip
          postcode = d.xpath('postalCode').text.strip
          city = d.xpath('city').text.strip
          country = d.xpath('country/term/localizedString').text.strip
          a = Puree::Model::Address.new
          a.street = street.empty? ? nil : street
          a.building = building.empty? ? nil : building
          a.postcode = postcode.empty? ? nil : postcode
          a.city = city.empty? ? nil : city
          a.country = country.empty? ? nil : country
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
        Puree::XMLExtractor::Shared.multi_header xpath_result
      end

      # @return [Puree::Model::OrganisationHeader]
      def parent
        data = organisations
        if !data.empty?
          return data.first
        end
        return nil
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