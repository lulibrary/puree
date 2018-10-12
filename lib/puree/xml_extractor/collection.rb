module Puree

  module XMLExtractor

    # Resource collection XML extractor.
    #
    module Collection

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

      # Get models from any multi-record person XML response
      #
      # @param xml [String]
      # @return [Array<Puree::Model::Publisher>]
      def self.publishers(xml)
        models :publisher, xml, '/publisher'
      end

      # Get models from any multi-record Research output XML response
      #
      # @param xml [String]
      # @return [Hash{Symbol => Array<Puree::Model::ResearchOutput class/subclass>}]
      def self.research_outputs(xml)
        path_from_root = File.join 'result', '/*'
        doc = Nokogiri::XML xml
        doc.remove_namespaces!
        xpath_result = doc.xpath path_from_root
        data = {
            journal_articles: [],
            conference_papers: [],
            theses: [],
            other: []
        }
        xpath_result.each do |research_output|
          type = research_output.xpath('type').text.strip
          unless type.empty?
            case type
              when 'Journal article'
                extractor = Puree::XMLExtractor::JournalArticle.new research_output.to_s
                data[:journal_articles] << extractor.model
              when 'Conference paper'
                extractor = Puree::XMLExtractor::ConferencePaper.new research_output.to_s
                data[:conference_papers] << extractor.model
              when 'Doctoral Thesis'
                extractor = Puree::XMLExtractor::Thesis.new research_output.to_s
                data[:theses] << extractor.model
              when "Master's Thesis"
                extractor = Puree::XMLExtractor::Thesis.new research_output.to_s
                data[:theses] << extractor.model
              else
                extractor = Puree::XMLExtractor::ResearchOutput.new research_output.to_s
                data[:other] << extractor.model
            end
          end
        end
        data
      end

      # Records available for a resource
      #
      def self.count(xml)
        doc = Nokogiri::XML xml
        doc.remove_namespaces!
        doc.xpath('/result/count').text.to_i
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