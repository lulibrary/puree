module Puree

  # Extractor
  #
  module Extractor

    # Event extractor
    #
    module Event

      def self.extract_date(xpath_result)
        data = {}
        data['start'] = xpath_result.xpath('startDate').text.strip
        data['end'] = xpath_result.xpath('startDate').text.strip
        data
      end

    end

  end

end