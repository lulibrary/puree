module Puree

  # Extractor
  #
  module Extractor

    # Person extractor
    #
    module Person

      def self.extract_affiliation(xpath_result)
        data_arr = []
        xpath_result.each { |i|
          data = {}
          data['uuid'] = i.attr('uuid').strip
          data['name'] = i.xpath('name/localizedString').text.strip
          data_arr << data
        }
        data_arr.uniq
      end

      def self.extract_name(xpath_result)
        first = xpath_result.xpath('firstName').text.strip
        last = xpath_result.xpath('lastName').text.strip
        o = {}
        o['first'] = first
        o['last'] = last
        o
      end

    end

  end

end