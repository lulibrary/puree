module Puree

  module XMLExtractor

    # Event XML extractor.
    #
    class Event < Puree::XMLExtractor::Resource
      include Puree::XMLExtractor::TitleMixin
      include Puree::XMLExtractor::TypeMixin

      def initialize(xml)
        super
        setup_model :event
      end

      # @return [String, nil]
      def city
        xpath_query_for_single_value '/city'
      end

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

      private

      def xpath_root
        '/event'
      end

      def combine_metadata
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