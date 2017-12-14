module Puree

  module XMLExtractor

    # Dataset collection XML extractor.
    #
    module ResourceCollection

      # Get models from any multi-record dataset XML response
      #
      # @param xml [String]
      # @return [Array<Puree::Model::Dataset>]
      def self.datasets(xml)
        models :dataset, xml, '/dataSet'
      end

      # Get models from any multi-record event XML response
      #
      # @param xml [String]
      # @return [Array<Puree::Model::Event>]
      def self.events(xml)
        models :event, xml, '/event'
      end

      # Get models from any multi-record external organisation XML response
      #
      # @param xml [String]
      # @return [Array<Puree::Model::ExternalOrganisation>]
      def self.external_organisations(xml)
        models :external_organisation, xml, '/externalOrganisation'
      end

      # Get models from any multi-record journal XML response
      #
      # @param xml [String]
      # @return [Array<Puree::Model::Journal>]
      def self.journals(xml)
        models :journal, xml, '/journal'
      end

      # Get models from any multi-record organisation XML response
      #
      # @param xml [String]
      # @return [Array<Puree::Model::OrganisationalUnit>]
      def self.organisational_units(xml)
        models :organisational_unit, xml, '/organisationalUnit'
      end

      # Get models from any multi-record project XML response
      #
      # @param xml [String]
      # @return [Array<Puree::Model::Project>]
      def self.projects(xml)
        models :project, xml, '/project'
      end

      # Get models from any multi-record person XML response
      #
      # @param xml [String]
      # @return [Array<Puree::Model::Person>]
      def self.persons(xml)
        models :person, xml, '/person'
      end

      private

      # Get models from any multi-record resource XML response
      #
      # @param xml [String]
      # @return [Array<Puree::Model::Resource subclass>]
      def self.models(resource_type, xml, xpath_root)
        doc = Nokogiri::XML xml
        doc.remove_namespaces!
        path_from_root = File.join 'result', xpath_root
        xpath_result = doc.xpath path_from_root
        data = []
        xpath_result.each do |i|
          xml_extractor = make_xml_extractor resource_type, i.to_s
          data << xml_extractor.model
        end
        data
      end

      def self.make_xml_extractor(resource_type, xml)
        resource_class = "Puree::XMLExtractor::#{Puree::Util::String.titleize(resource_type)}"
        Object.const_get(resource_class).new xml
      end

    end

  end

end