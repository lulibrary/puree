module Puree

  module XMLExtractor

    # Organisational unit XML extractor.
    #
    class OrganisationalUnit < Puree::XMLExtractor::Resource
      include Puree::XMLExtractor::TypeMixin

      def initialize(xml)
        super
        setup_model :organisational_unit
      end

      # @return [Puree::Model::Address]
      def address
        xpath_result = xpath_query '/addresses/address'
        if !xpath_result.empty?
          a = Puree::Model::Address.new
          street = xpath_result.xpath('street').text.strip
          a.street = street unless street.empty?
          building = xpath_result.xpath('building').text.strip
          a.building = building unless building.empty?
          postcode = xpath_result.xpath('postalcode').text.strip
          a.postcode = postcode unless building.empty?
          city = xpath_result.xpath('city').text.strip
          a.city = city unless city.empty?
          country = xpath_result.xpath('countries/country')
          a.country = country.first.text.strip if country
          a
        end
      end

      # @return [Array<String>]
      def email_addresses
        xpath_query_for_multi_value '/emails/email'
      end

      # @return [String, nil]
      def name
        xpath_query_for_multi_value('/names/name').first
      end

      # First parent
      # @return [Puree::Model::OrganisationalUnitHeader, nil]
      def parent
        multiple_parents = parents
        multiple_parents.empty? ? nil : multiple_parents.first
      end

      # @return [Array<Puree::Model::OrganisationalUnitHeader>]
      def parents
        xpath_result = xpath_query '/parents/parent'
        Puree::XMLExtractor::Shared.organisation_multi_header xpath_result if xpath_result
      end

      # @return [Array<String>]
      def phone_numbers
        xpath_query_for_multi_value '/phoneNumbers/phoneNumber'
      end

      # @return [Array<String>]
      def urls
        xpath_query_for_multi_value '/webAddresses/webAddress'
      end

      private

      def xpath_root
        '/organisationalUnit'
      end

      def combine_metadata
        super
        @model.address = address
        @model.email_addresses = email_addresses
        @model.name = name
        @model.parent = parent
        @model.parents = parents
        @model.phone_numbers = phone_numbers
        @model.type = type
        @model.urls = urls
        @model
      end      

    end

  end

end