module Puree

  # Extractor
  #
  module Extractor

    # Organisation extractor
    #
    class Organisation < Puree::Extractor::Base

      def initialize(xml:)
        @resource_type = :organisation
        super
      end

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

      def email
        xpath_query_for_multi_value '/emails/classificationDefinedStringFieldExtension/value'
      end

      def name
        xpath_query_for_single_value '/name/localizedString'
      end

      def organisation
        xpath_result = xpath_query '/organisations/organisation'
        Puree::Extractor::Shared.multi_header xpath_result
      end

      def parent
        data = organisation
        o = {}
        if !data.empty?
          o = data.first
        end
        o
      end

      def phone
        xpath_query_for_multi_value '/phoneNumbers/classificationDefinedStringFieldExtension/value'
      end

      def type
        xpath_query_for_single_value '/typeClassification/term/localizedString'
      end

      def url
        xpath_query_for_multi_value '/webAddresses/classificationDefinedFieldExtension/value/localizedString'
      end

    end

  end

end