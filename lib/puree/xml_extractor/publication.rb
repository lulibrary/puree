module Puree

  module XMLExtractor

    # Publication XML extractor.
    #
    class Publication < Puree::XMLExtractor::Resource
      include Puree::XMLExtractor::AssociatedMixin
      include Puree::XMLExtractor::AbstractMixin
      include Puree::XMLExtractor::ExternalOrganisationsMixin
      include Puree::XMLExtractor::KeywordMixin
      include Puree::XMLExtractor::OrganisationMixin
      include Puree::XMLExtractor::OwnerMixin
      include Puree::XMLExtractor::PersonMixin
      include Puree::XMLExtractor::WorkflowStateMixin
      include Puree::XMLExtractor::TitleMixin

      def initialize(xml:)
        @resource_type = :publication
        super
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
        persons 'internal'
      end

      # @return [Array<Puree::Model::EndeavourPerson>]
      def persons_external
        persons 'external'
      end

      # @return [Array<Puree::Model::EndeavourPerson>]
      def persons_other
        persons 'other'
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
        xpath_query_for_single_value '/subtitle'
      end

      # @return [String, nil]
      def translated_subtitle
        xpath_query_for_single_value '/translatedSubtitle'
      end

      # @return [String, nil]
      def translated_title
        xpath_query_for_single_value '/translatedTitle'
      end

      # @return [String, nil]
      def type
        xpath_query_for_single_value '/type'
      end

      private

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