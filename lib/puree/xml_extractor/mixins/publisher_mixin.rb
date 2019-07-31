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
        xpath_result_name = xpath_result.xpath('names/name')
        h.name = xpath_result_name.first.text.strip unless xpath_result_name.empty?
        xpath_result_type = xpath_result.xpath('types/type')
        h.type = xpath_result_type.first.text.strip unless xpath_result_type.empty?
        h.data? ? h : nil
      end

    end

  end
end
