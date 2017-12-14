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
        h.data? ? h : nil
      end

      # @return [Array<Puree::Model::ExternalOrganisationHeader>]
      def self.external_organisation_multi_header(nokogiri_xml_nodeset)
        data = []
        nokogiri_xml_nodeset.each do |i|
          header =  external_organisation_header(i)
          data << header if header
        end
        data.uniq { |d| d.uuid }
      end

      # @return [Puree::Model::OrganisationalUnitHeader]
      def self.organisation_header(nokogiri_xml_element)
        h = Puree::Model::OrganisationalUnitHeader.new
        h.uuid = nokogiri_xml_element.xpath('@uuid').text.strip
        h.name = nokogiri_xml_element.xpath('name').text.strip
        h.type = nokogiri_xml_element.xpath('type').text.strip
        h.data? ? h : nil
      end

      # @return [Array<Puree::Model::OrganisationalUnitHeader>]
      def self.organisation_multi_header(nokogiri_xml_nodeset)
        data = []
        nokogiri_xml_nodeset.each do |i|
          header = organisation_header(i)
          data << header if header
        end
        data.uniq { |d| d.uuid }
      end

    end

  end

end