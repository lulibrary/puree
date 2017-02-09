module Puree

  # Extractor
  #
  module Extractor

    # Generic extractor
    #
    module Generic

      def self.header(nokogiri_xml_element)
        o = {}
        o['uuid'] = nokogiri_xml_element.xpath('@uuid').text.strip
        o['name'] = nokogiri_xml_element.xpath('name/localizedString').text.strip
        o['type'] = nokogiri_xml_element.xpath('typeClassification/term/localizedString').text.strip
        o
      end

      def self.multi_header(nokogiri_xml_nodeset)
        data = []
        nokogiri_xml_nodeset.each do |i|
          data << header(i)
        end
        data.uniq
      end

    end

  end

end