module Puree

  module XMLExtractor

    # Shared XML extractor.
    #
    module Shared

      # @return [Puree::Model::ExternalOrganisationHeader]
      def self.external_organisation_header(nokogiri_xml_element)
        h = Puree::Model::ExternalOrganisationHeader.new
        h.uuid = nokogiri_xml_element.xpath('@uuid').text.strip
        h.name = nokogiri_xml_element.xpath('name').text.strip
        h
      end

      # @return [Array<Puree::Model::ExternalOrganisationHeader>]
      def self.external_organisation_multi_header(nokogiri_xml_nodeset)
        data = []
        nokogiri_xml_nodeset.each do |i|
          data << external_organisation_header(i)
        end
        data.uniq { |d| d.uuid }
      end

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
        data.uniq { |d| d.uuid }
      end

    end

  end

end