module Puree

  module XMLExtractor

    # Collection XML extractor.
    #
    class Collection < Puree::XMLExtractor::Base

      def initialize(xml:)
        super
      end

      # Records available in collection.
      #
      def count
        @doc.xpath('//count').text.strip.to_i
      end

      # Resource UUIDs in collection response.
      def uuids
        arr = []
        xpath_result = @doc.xpath '//renderedItem/@renderedContentUUID'
        xpath_result.each { |i| arr << i.text.strip }
        arr
      end

      # Is there any data after get?
      # @return [Boolean]
      def get_data?
        count >= 1 ? true : false
      end

    end

  end

end