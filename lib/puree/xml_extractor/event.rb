module Puree

  module XMLExtractor

    # Event XML extractor.
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

      # Pure Deprecated
      # @return [String, nil]
      # def country
      #   xpath_query_for_single_value '/country/term/localizedString'
      # end

      # @return [Puree::Model::TemporalRange, nil]
      def date
        xpath_result = xpath_query '/period'
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

      # Pure Deprecated
      # @return [String, nil]
      def location
        # xpath_query_for_single_value '/location'
      end

      # @return [String, nil]
      def title
        xpath_query_for_single_value '/title'
      end

      # @return [String, nil]
      def type
        xpath_query_for_single_value '/type'
      end

      private

      def xpath_root
        '/event'
      end

      def combine_metadata
        @model = Puree::Model::Event.new
        super
        @model.city = city
        @model.date = date
        @model.title = title
        @model.type = type
        @model
      end      

    end

  end

end