module Puree

  module XMLExtractor

    # Event extractor mixin.
    #
    module EventMixin

      # @return [Puree::Model::EventHeader, nil]
      def event
        xpath_result = xpath_query '/event'
        if !xpath_result.empty?
          header = Puree::Model::EventHeader.new
          header.uuid = xpath_result.xpath('@uuid').text.strip
          header.title = xpath_result.xpath('names/name').first.text.strip
          return header if header.data?
        end
        nil
      end

    end

  end
end
