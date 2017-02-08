module Puree

  # Extractor
  #
  module Extractor

    # Generic extractor
    #
    module Generic

      def self.header(xpath_result_node)
        o = {}
        o['uuid'] = xpath_result_node.xpath('@uuid').text.strip
        o['name'] = xpath_result_node.xpath('name/localizedString').text.strip
        o['type'] = xpath_result_node.xpath('typeClassification/term/localizedString').text.strip
        o
      end

      def self.multi_header(xpath_result)
        data = []
        xpath_result.each do |i|
          data << header(i)
        end
        data.uniq
      end

    end

  end

end