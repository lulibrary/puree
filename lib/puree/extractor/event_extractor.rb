module Puree

  # Extractor
  #
  module Extractor

    # Event extractor
    #
    class Event < Puree::Extractor::Resource

      def initialize(xml:)
        @resource_type = :event
        super
      end

      def city
        xpath_query('/city').text.strip
      end

      def country
        xpath_query('/country/term/localizedString').text.strip
      end

      def date
        xpath_result = xpath_query '/dateRange'
        data = {}
        data['start'] = xpath_result.xpath('startDate').text.strip
        data['end'] = xpath_result.xpath('startDate').text.strip
        data
      end

      def description
        xpath_query('/description').text.strip
      end

      def location
        xpath_query('/location').text.strip
      end

      def title
        xpath_query_for_single_value '/title/localizedString'
      end

      def type
        xpath_query_for_single_value '//typeClassification/term/localizedString'
      end

    end

  end

end