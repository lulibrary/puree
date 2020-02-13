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
          xpath_result_name = xpath_result.xpath('name/text')
          header.title = xpath_result_name.first.text.strip unless xpath_result_name.empty?
          return header if header.data?
        end
        nil
      end

    end

  end
end
