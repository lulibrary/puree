module Puree

  # Extractor
  #
  module Extractor

    # Organisation extractor
    #
    module Organisation

      def self.extract_address(xpath_result)
        data = []
        xpath_result.each do |d|
          o = {}
          o['street'] = d.xpath('street').text.strip
          o['building'] = d.xpath('building').text.strip
          o['postcode'] = d.xpath('postalCode').text.strip
          o['city'] = d.xpath('city').text.strip
          o['country'] = d.xpath('country/term/localizedString').text.strip
          data << o
        end
        data.uniq
      end

    end

  end

end