module Puree

  module XMLExtractor

    class Event < Puree::XMLExtractor::Resource

      def initialize(xml:)
        super
        @resource_type = :event
      end

      # @return [String, nil]
      def city
        xpath_query_for_single_value '/city'
      end

      # @return [String, nil]
      def country
        xpath_query_for_single_value '/country/term/localizedString'
      end

      # @return [Puree::Model::TemporalRange]
      def date
        xpath_result = xpath_query '/dateRange'
        data = {}
        data['start'] = xpath_result.xpath('startDate').text.strip
        data['end'] = xpath_result.xpath('endDate').text.strip
        range = Puree::Model::TemporalRange.new
        range.start = Time.parse data['start']
        if data['end']['year']
          range.end = Time.parse data['end']
        end
        range
      end

      # @return [String, nil]
      def description
        xpath_query_for_single_value  '/description'
      end

      # @return [String, nil]
      def location
        xpath_query_for_single_value '/location'
      end

      # @return [String, nil]
      def title
        xpath_query_for_single_value '/title/localizedString'
      end

      # @return [String, nil]
      def type
        xpath_query_for_single_value '//typeClassification/term/localizedString'
      end

    end

  end

end