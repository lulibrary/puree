module Puree

  module XMLExtractor

    # Shared XML extractor
    #
    module Shared

      # @return [Puree::Model::OrganisationHeader]
      def self.organisation_header(nokogiri_xml_element)
        h = Puree::Model::OrganisationHeader.new
        h.uuid = nokogiri_xml_element.xpath('@uuid').text.strip
        h.name = nokogiri_xml_element.xpath('name/localizedString').text.strip
        h.type = nokogiri_xml_element.xpath('typeClassification/term/localizedString').text.strip
        h
      end

      # @return [Array<Puree::Model::OrganisationHeader>]
      def self.organisation_multi_header(nokogiri_xml_nodeset)
        data = []
        nokogiri_xml_nodeset.each do |i|
          data << organisation_header(i)
        end
        data.uniq
      end

    end

  end

end