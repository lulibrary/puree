module Puree

  module XMLExtractor

    # Publisher extractor mixin.
    #
    module PublisherMixin

      # @return [Puree::Model::PublisherHeader, nil]
      def publisher
        xpath_result = xpath_query '/publisher'
        h = Puree::Model::PublisherHeader.new
        h.uuid = xpath_result.xpath('@uuid').text.strip
        h.name = xpath_result.xpath('names/name').first.text.strip
        h.type = xpath_result.xpath('types/type').first.text.strip
        h.data? ? h : nil
      end

    end

  end
end
