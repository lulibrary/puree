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

    end

  end

end