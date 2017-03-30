module Puree

  module XMLExtractor

    # Publication XMLextractor.
    #
    class Publication < Puree::XMLExtractor::Resource

      def initialize(xml:)
        @resource_type = :publication
        super
      end

      # @return [String, nil]
      def category
        xpath_query_for_single_value '/publicationCategory/publicationCategory/term/localizedString'
      end

      # @return [String, nil]
      def description
        xpath_query_for_single_value '/abstract/localizedString'
      end

      # @return [String, nil]
      def doi
        xpath_query_for_single_value '//doi'
      end

      # @return [Puree::Model::EventHeader, nil]
      def event
        xpath_result = xpath_query '/event'
        if !xpath_result.empty?
          header = Puree::Model::EventHeader.new
          header.uuid = xpath_result.xpath('@uuid').text.strip
          header.title = xpath_result.xpath('title/localizedString').text.strip
          return header if header.data?
        end
        nil
      end

      # @return [Array<Puree::Model::File>]
      def files
        xpath_result = xpath_query '/electronicVersionAssociations/electronicVersionFileAssociations/electronicVersionFileAssociation'
        docs = []
        xpath_result.each do |d|
          model = Puree::Model::File.new
          model.name = d.xpath('file/fileName').text.strip
          model.mime = d.xpath('file/mimeType').text.strip
          model.size = d.xpath('file/size').text.strip.to_i
          model.url = d.xpath('file/url').text.strip
          document_license = d.xpath('licenseType')
          if !document_license.empty?
            license = Puree::Model::CopyrightLicense.new
            license.name = document_license.xpath('term/localizedString').text.strip
            license.url = document_license.xpath('description/localizedString').text.strip
            model.license = license if license.data?
          end
          docs << model
        end
        docs.uniq { |d| d.url }
      end

      # @return [Array<String>]
      def keywords
        xpath_result =  xpath_query '/keywordGroups/keywordGroup/keyword/userDefinedKeyword/freeKeyword'
        data_arr = xpath_result.map { |i| i.text.strip }
        data_arr.uniq
      end

      # @return [Array<Puree::Model::OrganisationHeader>]
      def organisations
        xpath_result = xpath_query '/organisations/association/organisation'
        Puree::XMLExtractor::Shared.organisation_multi_header xpath_result
      end

      # @return [Puree::Model::OrganisationHeader, nil]
      def owner
        xpath_result = xpath_query '/owner'
        Puree::XMLExtractor::Shared.organisation_header xpath_result
      end

      # @return [Fixnum, nil]
      def pages
        xpath_result = xpath_query_for_single_value('/numberOfPages')
        xpath_result ? xpath_result.to_i : nil
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

      # @return [String, nil]
      def publisher
        xpath_query_for_single_value '/associatedPublisher/publisher/name'
      end

      # @return [Array<Puree::Model::PublicationStatus>]
      def statuses
        xpath_result = xpath_query '/publicationStatuses/publicationStatus'
        data = []
        xpath_result.each do |i|
          s = Puree::Model::PublicationStatus.new
          s.stage = i.xpath('publicationStatus/term/localizedString').text.strip

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
      def title
        xpath_query_for_single_value '/title'
      end

      # @return [String, nil]
      def type
        xpath_query_for_single_value '/typeClassification/term/localizedString'
      end

      private

      # @return [Array<Endeavour::Person>]
      def persons(type)
        xpath_result = xpath_query '/persons/personAssociation'
        arr = []
        xpath_result.each do |i|
          uuid_internal = i.at_xpath('person/@uuid')
          uuid_external = i.at_xpath('externalPerson/@uuid')
          if uuid_internal
            person_type = 'internal'
            uuid = uuid_internal.text.strip
          elsif uuid_external
            person_type = 'external'
            uuid = uuid_external.text.strip
          else
            person_type = 'other'
            uuid = ''
          end
          if person_type === type
            person = Puree::Model::EndeavourPerson.new
            person.uuid = uuid

            name = Puree::Model::PersonName.new
            name.first = i.xpath('name/firstName').text.strip
            name.last = i.xpath('name/lastName').text.strip
            person.name = name

            role_uri = i.xpath('personRole/uri').text.strip
            person.role = roles[role_uri]

            arr << person if person.data?
          end
        end
        arr.uniq { |d| d.uuid }
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
            # Translator
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