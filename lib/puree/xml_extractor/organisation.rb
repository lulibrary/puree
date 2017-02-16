module Puree

  module XMLExtractor

    class Organisation < Puree::XMLExtractor::Resource

      def initialize(xml:)
        super
        @resource_type = :organisation
      end

      # @return [Array<Hash>]
      def address
        xpath_result = xpath_query '/addresses/classifiedAddress'
        data = []
        xpath_result.each do |d|
          o = {}
          o['street'] = d.xpath('street').text.strip
          o['building'] = d.xpath('building').text.strip
          o['postcode'] = d.xpath('postalCode').text.strip
          o['city'] = d.xpath('city').text.strip
          o['country'] = d.xpath('country/term/localizedString').text.strip
          data << o
        end
        data.uniq
      end

      # @return [Array<String>]
      def email
        xpath_query_for_multi_value '/emails/classificationDefinedStringFieldExtension/value'
      end

      # @return [String]
      def name
        xpath_query_for_single_value '/name/localizedString'
      end

      # @return [Array<Hash>]
      def organisation
        xpath_result = xpath_query '/organisations/organisation'
        Puree::XMLExtractor::Shared.multi_header xpath_result
      end

      # @return [Hash]
      def parent
        data = organisation
        o = {}
        if !data.empty?
          o = data.first
        end
        o
      end

      # @return [Array<String>]
      def phone
        xpath_query_for_multi_value '/phoneNumbers/classificationDefinedStringFieldExtension/value'
      end

      # @return [String]
      def type
        xpath_query_for_single_value '/typeClassification/term/localizedString'
      end

      # @return [Array<String>]
      def url
        xpath_query_for_multi_value '/webAddresses/classificationDefinedFieldExtension/value/localizedString'
      end

    end

  end

end