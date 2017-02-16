module Puree

  module XMLExtractor

    class Event < Puree::XMLExtractor::Resource

      def initialize(xml:)
        super
        @resource_type = :event
      end

      # @return [String]
      def city
        xpath_query('/city').text.strip
      end

      # @return [String]
      def country
        xpath_query('/country/term/localizedString').text.strip
      end

      # @return [Hash]
      def date
        xpath_result = xpath_query '/dateRange'
        data = {}
        data['start'] = xpath_result.xpath('startDate').text.strip
        data['end'] = xpath_result.xpath('startDate').text.strip
        data
      end

      # @return [String]
      def description
        xpath_query('/description').text.strip
      end

      # @return [String]
      def location
        xpath_query('/location').text.strip
      end

      # @return [String]
      def title
        xpath_query_for_single_value '/title/localizedString'
      end

      # @return [String]
      def type
        xpath_query_for_single_value '//typeClassification/term/localizedString'
      end

    end

  end

end