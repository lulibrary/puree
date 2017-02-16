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

      # @return [Hash]
      def event
        xpath_result = xpath_query '/event'
        o = {}
        o['uuid'] = xpath_result.xpath('@uuid').text.strip
        o['title'] = xpath_result.xpath('title/localizedString').text.strip
        o
      end

      # @return [String]
      def doi
        xpath_query_for_single_value '//doi'
      end

      # @return [Array<Hash>]
      def file
        xpath_result = xpath_query '/electronicVersionAssociations/electronicVersionFileAssociations/electronicVersionFileAssociation/file'
        docs = []
        xpath_result.each do |d|
          doc = {}
          # doc['id'] = d.xpath('id').text
          doc['name'] = d.xpath('fileName').text.strip
          doc['mime'] = d.xpath('mimeType').text.strip
          doc['size'] = d.xpath('size').text.strip
          doc['url'] = d.xpath('url').text.strip
          docs << doc
        end
        docs.uniq
      end

      # @return [Array<Hash>]
      def organisation
        xpath_result = xpath_query '/organisations/association/organisation'
        Puree::XMLExtractor::Shared.multi_header xpath_result
      end

      # @return [String]
      def page
        xpath_query_for_single_value '/numberOfPages'
      end

      # Person (internal, external, other)
      # @return [Hash<Array,Array,Array>]
      def person
        xpath_result = xpath_query '/persons/personAssociation'
        data = {}
        internal = []
        external = []
        other = []
        xpath_result.each do |i|
          o = {}
          name = {}
          name['first'] = i.xpath('name/firstName').text.strip
          name['last'] = i.xpath('name/lastName').text.strip
          o['name'] = name
          o['role'] = 'Author'

          uuid_internal = i.at_xpath('person/@uuid')
          uuid_external = i.at_xpath('externalPerson/@uuid')
          if uuid_internal
            o['uuid'] = uuid_internal.text.strip
            internal << o
          elsif uuid_external
            o['uuid'] = uuid_external.text.strip
            external << o
          else
            other << o
            o['uuid'] = ''
          end
        end
        data['internal'] = internal
        data['external'] = external
        data['other'] = other
        data
      end

      # @return [Array<Hash>]
      def status
        xpath_result = xpath_query '/publicationStatuses/publicationStatus'
        data = []
        xpath_result.each do |i|
          o = {}
          o['stage'] = i.xpath('publicationStatus/term/localizedString').text.strip
          ymd = {}
          ymd['year'] = i.xpath('publicationDate/year').text.strip
          ymd['month'] = i.xpath('publicationDate/month').text.strip
          ymd['day'] = i.xpath('publicationDate/day').text.strip
          o['date'] = Puree::Date.normalise(ymd)
          data << o
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

    end

  end

end