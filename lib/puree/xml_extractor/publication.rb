module Puree

  module XMLExtractor

    # Publication XML extractor.
    #
    class Publication < Puree::XMLExtractor::Resource
      include Puree::XMLExtractor::AssociatedMixin
      include Puree::XMLExtractor::AbstractMixin
      include Puree::XMLExtractor::KeywordMixin
      include Puree::XMLExtractor::OrganisationMixin
      include Puree::XMLExtractor::OwnerMixin
      include Puree::XMLExtractor::PersonMixin
      include Puree::XMLExtractor::WorkflowMixin
      include Puree::XMLExtractor::TitleMixin
      include Puree::XMLExtractor::TypeMixin

      def initialize(xml)
        super
        setup_model :publication
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

      # Pure deprecated
      # @return [String, nil]
      # def publication_place
      #   # handles variations in path
      #   xpath_result = xpath_query_for_single_value '/associatedPublisher/placeOfPublication'
      #   xpath_result = xpath_query_for_single_value '/associatedPublishers/placeOfPublication' if !xpath_result
      #   xpath_result
      # end

      # Pure deprecated
      # @return [String, nil]
      # def publisher
      #   xpath_query_for_single_value '/publisher'
      # end

      # @return [Fixnum, nil]
      def scopus_citations_count
        xpath_result = xpath_query_for_single_value '/totalScopusCitations'
        xpath_result ? xpath_result.to_i : nil
      end

      # @return [Array<Puree::Model::ScopusMetric>]
      def scopus_metrics
        xpath_result = xpath_query '/scopusMetrics/scopusMetric'
        data = []
        xpath_result.each do |i|
          s = Puree::Model::ScopusMetric.new
          s.value = i.xpath('value').text.strip
          s.year = i.xpath('year').text.strip
          data << s
        end
        data
      end

      # @return [Array<Puree::Model::PublicationStatus>]
      def statuses
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

      # Get models from any multi-record Research Output XML response
      #
      # @param xml [String]
      # @return [Hash{Symbol => Array<Puree::Model::Publication class/subclass>}]
      def classify(xml)
        path_from_root = File.join 'result', xpath_root
        doc = Nokogiri::XML xml
        doc.remove_namespaces!
        xpath_result = doc.xpath path_from_root
        outputs = {
          journal_article: [],
          paper: [],
          thesis: [],
          other: []
        }
        xpath_result.each do |research_output|
          type = research_output.xpath('type').text.strip
          unless type.empty?
            case type
              when 'Journal article'
                extractor = Puree::Extractor::JournalArticle.new config
                model = extractor.extract research_output.to_s
                outputs[:journal_article] << model
              when 'Conference paper'
                extractor = Puree::Extractor::Paper.new config
                model = extractor.extract research_output.to_s
                outputs[:paper] << model
              when 'Doctoral Thesis'
                extractor = Puree::Extractor::Thesis.new config
                model = extractor.extract research_output.to_s
                outputs[:thesis] << model
              when "Master's Thesis"
                extractor = Puree::Extractor::Thesis.new config
                model = extractor.extract research_output.to_s
                outputs[:thesis] << model
              else
                extractor = Puree::Extractor::Publication.new config
                model = extractor.extract research_output.to_s
                outputs[:other] << model
            end
          end
        end
        outputs
      end

      private

      def xpath_root
        '/*'
      end

      def combine_metadata
        super
        @model.associated = associated
        @model.bibliographical_note = bibliographical_note
        @model.category = category
        @model.description = description
        @model.doi = doi
        @model.files = files
        @model.keywords = keywords
        @model.language = language
        @model.links = links
        @model.organisations = organisations
        @model.owner = owner
        @model.persons_internal = persons_internal
        @model.persons_external = persons_external
        @model.persons_other = persons_other
        @model.scopus_citations_count = scopus_citations_count
        @model.statuses = statuses
        @model.subtitle = subtitle
        @model.title = title
        @model.translated_subtitle = translated_subtitle
        @model.translated_title = translated_title
        @model.type = type
        @model.workflow = workflow
        @model
      end

      def roles
        {
            # Should build using '/dk/atira/pure/researchoutput/roles/' as prefix, with parameter

            ## Article
            '/dk/atira/pure/researchoutput/roles/contributiontojournal/author'          => 'Author',
            '/dk/atira/pure/researchoutput/roles/contributiontojournal/illustrator'     => 'Illustrator',
            '/dk/atira/pure/researchoutput/roles/contributiontojournal/editor'          => 'Editor',
            '/dk/atira/pure/researchoutput/roles/contributiontojournal/translator'      => 'Translator',
            '/dk/atira/pure/researchoutput/roles/contributiontojournal/publisher'       => 'Publisher',
            '/dk/atira/pure/researchoutput/roles/contributiontojournal/guesteditor'     => 'Guest Editor',

            ## Chapter
            # Author
            # Illustrator
            # Editor
            # Translator      # # @return [Fixnum, nil]
      # def pages
      #   xpath_result = xpath_query_for_single_value('/numberOfPages')
      #   xpath_result ? xpath_result.to_i : nil
      # end
            # Publisher

            # ... many, many more research output types ...

            # Examples of others
            '/dk/atira/pure/researchoutput/roles/bookanthology/author'                   => 'Author',
            '/dk/atira/pure/researchoutput/roles/othercontribution/author'               => 'Author',
            '/dk/atira/pure/researchoutput/roles/thesis/author'                          => 'Author',
            '/dk/atira/pure/researchoutput/roles/workingpaper/author'                    => 'Author',
            '/dk/atira/pure/researchoutput/roles/internalexternal/thesis/supervisor'     => 'Supervisor',
            '/dk/atira/pure/researchoutput/roles/nontextual/artist'                      => 'Artist'
        }
      end

    end

  end

end