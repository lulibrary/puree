module Puree

  module XMLExtractor

    # Organisation XML extractor.
    #
    class Organisation < Puree::XMLExtractor::Resource

      def initialize(xml:)
        super
        @resource_type = :organisation
      end

      # @return [Puree::Model::Address]
      def address
        xpath_result = xpath_query '/addresses/address'
        if xpath_result
          a = Puree::Model::Address.new
          street = xpath_result.xpath('street').text.strip
          a.street = street unless street.empty?
          building = xpath_result.xpath('building').text.strip
          a.building = building unless building.empty?
          postcode = xpath_result.xpath('postalCode').text.strip
          a.postcode = postcode unless building.empty?
          city = xpath_result.xpath('city').text.strip
          a.city = city unless city.empty?
          country = xpath_result.xpath('country').text.strip
          a.country = country unless country.empty?
          a
        end
      end

      # @return [Array<String>]
      def email_addresses
        xpath_query_for_multi_value '/emails/email'
      end

      # @return [String, nil]
      def name
        xpath_query_for_single_value '/name'
      end

      # Pure deprecated
      # @return [Array<Puree::Model::OrganisationHeader>]
      # def organisations
      #   xpath_result = xpath_query '/organisations/organisation'
      #   Puree::XMLExtractor::Shared.organisation_multi_header xpath_result
      # end


      # @return [Puree::Model::OrganisationHeader, nil]
      def parent
        xpath_result = xpath_query '/parents/parent'
        Puree::XMLExtractor::Shared.organisation_header xpath_result
      end

      # @return [Array<String>]
      def phone_numbers
        xpath_query_for_multi_value '/phoneNumbers/phoneNumber'
      end

      # @return [String, nil]
      def type
        xpath_query_for_single_value '/type'
      end

      # @return [Array<String>]
      def urls
        xpath_query_for_multi_value '/webAddresses/webAddress'
      end

      private

      def xpath_root
        '/organisationalUnit'
      end

    end

  end

end