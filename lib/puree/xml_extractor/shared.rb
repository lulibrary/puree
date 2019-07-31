module Puree

  module XMLExtractor

    # Shared XML extractor.
    #
    module Shared

      # @return [Puree::Model::ExternalOrganisationHeader]
      def self.external_organisation_header(nokogiri_xml_element)
        h = Puree::Model::ExternalOrganisationHeader.new
        h.uuid = nokogiri_xml_element.xpath('@uuid').text.strip
        xpath_result_name = nokogiri_xml_element.xpath('names/name')
        h.name = xpath_result_name.first.text.strip unless xpath_result_name.empty?
        xpath_result_type = nokogiri_xml_element.xpath('types/type')
        h.type = xpath_result_type.first.text.strip unless xpath_result_type.empty?
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
        xpath_result_name = nokogiri_xml_element.xpath('names/name')
        h.name = xpath_result_name.first.text.strip unless xpath_result_name.empty?
        xpath_result_type = nokogiri_xml_element.xpath('types/type')
        h.type = xpath_result_type.first.text.strip unless xpath_result_type.empty?
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