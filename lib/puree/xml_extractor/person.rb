module Puree

  module XMLExtractor

    class Person < Puree::XMLExtractor::Resource

      def initialize(xml:)
        super
        @resource_type = :person
      end

      # @return [Array<Puree::Model::OrganisationHeader>]
      def affiliations
        xpath_result = xpath_query '//organisation'
        Puree::XMLExtractor::Shared.multi_header xpath_result
      end

      # @return [Array<String>]
      def email_addresses
        xpath_query_for_multi_value '//emails/classificationDefinedStringFieldExtension/value'
      end

      # @return [Array<String>]
      def image_urls
        xpath_query_for_multi_value '/photos/file/url'
      end

      # @return [Array<String>]
      def keywords
        xpath_query_for_multi_value '//keywordGroup/keyword/userDefinedKeyword/freeKeyword'
      end

      # @return [Puree::Model::PersonName]
      def name
        xpath_result = xpath_query '/name'
        first = xpath_result.xpath('firstName').text.strip
        last = xpath_result.xpath('lastName').text.strip
        o = {}
        o['first'] = first
        o['last'] = last
        model = Puree::Model::PersonName.new
        model.first = first
        model.last = last
        model
      end

      # @return [String]
      def orcid
        xpath_query_for_single_value '/orcid'
      end

    end

  end

end