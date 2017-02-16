module Puree

  module XMLExtractor

    class Person < Puree::XMLExtractor::Resource

      def initialize(xml:)
        super
        @resource_type = :person
      end

      # @return [Array<Hash>]
      def affiliation
        xpath_result = xpath_query '//organisation'
        data_arr = []
        xpath_result.each { |i|
          data = {}
          data['uuid'] = i.attr('uuid').strip
          data['name'] = i.xpath('name/localizedString').text.strip
          data_arr << data
        }
        data_arr.uniq
      end

      # @return [Array]
      def email
        xpath_query_for_multi_value '//emails/classificationDefinedStringFieldExtension/value'
      end

      # Image URL
      # @return [Array<String>]
      def image
        xpath_query_for_multi_value '/photos/file/url'
      end

      # @return [Array<String>]
      def keyword
        xpath_query_for_multi_value '//keywordGroup/keyword/userDefinedKeyword/freeKeyword'
      end

      # @return [Hash]
      def name
        xpath_result = xpath_query '/name'
        first = xpath_result.xpath('firstName').text.strip
        last = xpath_result.xpath('lastName').text.strip
        o = {}
        o['first'] = first
        o['last'] = last
        o
      end

      # @return [String]
      def orcid
        xpath_query_for_single_value '/orcid'
      end

    end

  end

end