module Puree

  module XMLExtractor

    class Publication < Puree::XMLExtractor::Resource

      def initialize(xml:)
        @resource_type = :publication
        super
      end

      # @return [String]
      def category
        xpath_query_for_single_value '/publicationCategory/publicationCategory/term/localizedString'
      end

      # @return [String]
      def description
        xpath_query_for_single_value '/abstract/localizedString'
      end

      # @return [Puree::Model::EventHeader]
      def event
        xpath_result = xpath_query '/event'
        header = Puree::Model::EventHeader.new
        if !xpath_result.nil?
          header.uuid = xpath_result.xpath('@uuid').text.strip
          header.title = xpath_result.xpath('title/localizedString').text.strip
        end
        header
      end

      # @return [String]
      def doi
        xpath_query_for_single_value '//doi'
      end

      # @return [Array<Puree::Model::File>]
      def files
        xpath_result = xpath_query '/electronicVersionAssociations/electronicVersionFileAssociations/electronicVersionFileAssociation/file'
        docs = []
        xpath_result.each do |d|
          model = Puree::Model::File.new
          model.name = d.xpath('fileName').text.strip
          model.mime = d.xpath('mimeType').text.strip
          model.size = d.xpath('size').text.strip.to_i
          model.url = d.xpath('url').text.strip
          docs << model
        end
        docs.uniq
      end

      # @return [Array<Puree::Model::OrganisationHeader>]
      def organisations
        xpath_result = xpath_query '/organisations/association/organisation'
        Puree::XMLExtractor::Shared.multi_header xpath_result
      end

      # @return [Fixnum]
      def page
        xpath_query_for_single_value('/numberOfPages').to_i
      end

      # Internal persons
      # @return [Array<Puree::Model::EndeavourPerson>]
      def persons_internal
        persons 'internal'
      end

      # External persons
      # @return [Array<Puree::Model::EndeavourPerson>]
      def persons_external
        persons 'external'
      end

      # Other persons
      # @return [Array<Puree::Model::EndeavourPerson>]
      def persons_other
        persons 'other'
      end

      # @return [Array<Puree::Model::PublicationStatus>]
      def statuses
        xpath_result = xpath_query '/publicationStatuses/publicationStatus'
        data = []
        xpath_result.each do |i|
          s = Puree::Model::PublicationStatus.new
          s.stage = i.xpath('publicationStatus/term/localizedString').text.strip
          # s.date =
          # o = {}
          # o['stage'] = i.xpath('publicationStatus/term/localizedString').text.strip
          ymd = {}
          ymd['year'] = i.xpath('publicationDate/year').text.strip
          ymd['month'] = i.xpath('publicationDate/month').text.strip
          ymd['day'] = i.xpath('publicationDate/day').text.strip

          # iso = Puree::Util::Date.iso ymd
          # o['date'] = Puree::Util::Date.iso_date_to_time iso
          #
          # s.date = Puree::Util::Date.iso_date_to_time iso

          s.date = Puree::Util::Date.hash_to_time ymd

          data << s
        end
        data
      end

      # @return [String]
      def title
        xpath_query_for_single_value '/title'
      end

      # @return [String]
      def subtitle
        xpath_query_for_single_value '/subtitle'
      end

      # @return [String]
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
            person.role = roles[role_uri].to_s
            arr << person
          end
        end
        arr
      end

      def roles
        {
            '/dk/atira/pure/researchoutput/roles/bookanthology/author'                   => 'Author',
            '/dk/atira/pure/researchoutput/roles/contributiontojournal/author'           => 'Author',
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