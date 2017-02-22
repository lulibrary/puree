module Puree

  module XMLExtractor

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

      # @return [Puree::Model::EventHeader]
      def event
        xpath_result = xpath_query '/event'
        if !xpath_result.empty?
          header = Puree::Model::EventHeader.new
          header.uuid = xpath_result.xpath('@uuid').text.strip
          header.title = xpath_result.xpath('title/localizedString').text.strip
          header
        end
      end

      # @return [String, nil]
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
          model.size = d.xpath('size').text.strip
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

      # @return [Fixnum, nil]
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

      # @return [String, nil]
      def title
        xpath_query_for_single_value '/title'
      end

      # @return [String, nil]
      def subtitle
        xpath_query_for_single_value '/subtitle'
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
          person = Puree::Model::EndeavourPerson.new

          name = Puree::Model::PersonName.new
          name.first = i.xpath('name/firstName').text.strip
          name.last = i.xpath('name/lastName').text.strip
          person.name = name

          person.role = 'Author'

          if type === 'internal'
            uuid = i.at_xpath('person/@uuid')
          elsif type === 'external'
            uuid = i.at_xpath('externalPerson/@uuid')
          end
          if uuid
            uuid = uuid.text.strip
          end
          person.uuid = uuid

          arr << person
        end
        arr
      end

    end

  end

end