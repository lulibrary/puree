module Puree

  module XMLExtractor

    # Research output XML extractor.
    #
    class ResearchOutput < Puree::XMLExtractor::Resource
      include Puree::XMLExtractor::AbstractMixin
      include Puree::XMLExtractor::KeywordMixin
      include Puree::XMLExtractor::OrganisationalUnitMixin
      include Puree::XMLExtractor::OwnerMixin
      include Puree::XMLExtractor::PersonMixin
      include Puree::XMLExtractor::ResearchOutputMixin
      include Puree::XMLExtractor::WorkflowMixin
      include Puree::XMLExtractor::TitleMixin
      include Puree::XMLExtractor::TypeMixin

      def initialize(xml)
        super
        setup_model :research_output
      end

      # @return [String, nil]
      def bibliographical_note
        xpath_query_for_single_value('/bibliographicalNote')
      end

      # @return [String, nil]
      def category
        xpath_query_for_single_value '/category'
      end

      # Digital Object Identifier
      # @return [String, nil]
      def doi
        xpath_query_for_single_value '/electronicVersions/electronicVersion[@type="wsElectronicVersionDoiAssociation"]/doi'
      end

      # @return [Array<Puree::Model::File>]
      def files
        xpath_result = xpath_query '/electronicVersions/electronicVersion[@type="wsElectronicVersionFileAssociation"]'
        docs = []
        xpath_result.each do |d|
          model = Puree::Model::File.new
          model.name = d.xpath('file/fileName').text.strip
          model.mime = d.xpath('file/mimeType').text.strip
          model.size = d.xpath('file/size').text.strip.to_i
          model.url = d.xpath('file/URL').text.strip
          # document_license = d.xpath('licenseType')
          # if !document_license.empty?
          #   license = Puree::Model::CopyrightLicense.new
          #   license.name = document_license.xpath('term/localizedString').text.strip
          #   license.url = document_license.xpath('description/localizedString').text.strip
          #   model.license = license if license.data?
          # end
          docs << model
        end
        docs.uniq { |d| d.url }
      end

      # @return [Array<String>]
      def keywords
        keyword_group 'keywordContainers'
      end

      # @return [String, nil]
      def language
        xpath_query_for_single_value '/language'
      end

      # @return [Array<String>, nil]
      def links
        xpath_query_for_multi_value '/electronicVersions/electronicVersion[@type="wsElectronicVersionLinkAssociation"]/link'
      end

      # @return [String, nil]
      def open_access_permission
        xpath_query_for_single_value '/openAccessPermission'
      end

      # @return [Array<Puree::Model::EndeavourPerson>]
      def persons_internal
        persons 'internal', '/personAssociations/personAssociation'
      end

      # @return [Array<Puree::Model::EndeavourPerson>]
      def persons_external
        persons 'external', '/personAssociations/personAssociation'
      end

      # @return [Array<Puree::Model::EndeavourPerson>]
      def persons_other
        persons 'other', '/personAssociations/personAssociation'
      end

      # @return [Array<Puree::Model::PublicationStatus>]
      def publication_statuses
        xpath_result = xpath_query '/publicationStatuses/publicationStatus'
        data = []
        xpath_result.each do |i|
          s = Puree::Model::PublicationStatus.new
          s.stage = i.xpath('publicationStatus').text.strip

          ymd = {}
          ymd['year'] = i.xpath('publicationDate/year').text.strip
          ymd['month'] = i.xpath('publicationDate/month').text.strip
          ymd['day'] = i.xpath('publicationDate/day').text.strip

          s.date = Puree::Util::Date.hash_to_time ymd

          data << s
        end
        data.uniq { |d| d.stage }
      end

      # @return [Fixnum, nil]
      def scopus_citations_count
        xpath_result = xpath_query_for_single_value '/totalScopusCitations'
        xpath_result ? xpath_result.to_i : nil
      end

      # @return [String, nil]
      def scopus_id
        xpath_result = xpath_query '/externalableInfo/secondarySources/secondarySource'
        return if xpath_result.empty?
        source = xpath_result.xpath('source')
        if source && source.text.strip.downcase === 'scopus'
          return xpath_result.xpath('sourceId').text.strip
        end
      end

      # @return [Array<Puree::Model::ResearchOutputScopusMetric>]
      def scopus_metrics
        xpath_result = xpath_query '/scopusMetrics/scopusMetric'
        data = []
        xpath_result.each do |i|
          s = Puree::Model::ResearchOutputScopusMetric.new
          s.value = i.xpath('value').text.strip
          s.year = i.xpath('year').text.strip
          data << s
        end
        data
      end

      # @return [String, nil]
      def subtitle
        xpath_query_for_single_value '/subTitle'
      end

      # @return [String, nil]
      def translated_subtitle
        xpath_query_for_single_value '/translatedSubTitle'
      end

      # @return [String, nil]
      def translated_title
        xpath_query_for_single_value '/translatedTitle'
      end

      private

      def xpath_root
        '/*'
      end

      def combine_metadata
        super
        @model.bibliographical_note = bibliographical_note
        @model.category = category
        @model.description = description
        @model.doi = doi
        @model.files = files
        @model.keywords = keywords
        @model.language = language
        @model.links = links
        @model.open_access_permission = open_access_permission
        @model.organisations = organisational_units
        @model.owner = owner
        @model.persons_internal = persons_internal
        @model.persons_external = persons_external
        @model.persons_other = persons_other
        @model.publication_statuses = publication_statuses
        @model.research_outputs = research_outputs
        @model.scopus_citations_count = scopus_citations_count
        @model.scopus_id = scopus_id
        @model.scopus_metrics = scopus_metrics
        @model.subtitle = subtitle
        @model.title = title
        @model.translated_subtitle = translated_subtitle
        @model.translated_title = translated_title
        @model.type = type
        @model.workflow = workflow
        @model
      end

    end

  end

end