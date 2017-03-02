module Puree

  module XMLExtractor

    # Event XML extractor
    #
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

      # @return [Puree::Model::TemporalRange, nil]
      def date
        xpath_result = xpath_query '/dateRange'
        range_start_str = xpath_result.xpath('startDate').text.strip
        range_end_str = xpath_result.xpath('endDate').text.strip
        if !range_start_str.empty?
          range = Puree::Model::TemporalRange.new
          range.start = Time.parse range_start_str
          if !range_end_str.empty?
            range.end = Time.parse range_end_str
          end
          range
        end
      end

      # @return [String, nil]
      def description
        xpath_query_for_single_value '/description'
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