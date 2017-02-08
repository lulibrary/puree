module Puree

  # Extractor
  #
  module Extractor

    # Organisation extractor
    #
    module Organisation

      def self.simple(xpath_result)
        data = []
        xpath_result.each do |i|
          o = {}
          o['uuid'] = i.xpath('@uuid').text.strip
          o['name'] = i.xpath('name/localizedString').text.strip
          o['type'] = i.xpath('typeClassification/term/localizedString').text.strip
          data << o
        end
        data.uniq
      end

    end

  end

end