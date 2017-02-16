module Puree

  module XMLExtractor

    class Project < Puree::XMLExtractor::Resource

      def initialize(xml:)
        super
        @resource_type = :project
      end

      # @return [String]
      def acronym
        xpath_query_for_single_value '/acronym'
      end

      # @return [String]
      def description
        xpath_query_for_single_value '/description/localizedString'
      end

      # @return [Array<Hash>]
      def organisation
        xpath_result = xpath_query '/organisations/association/organisation'
        Puree::XMLExtractor::Shared.multi_header xpath_result
      end

      # @return [Hash]
      def owner
        xpath_result =  xpath_query '/owner'
        Puree::XMLExtractor::Shared.header xpath_result
      end

      # @return [Hash<Array,Array,Array>]
      def person
        xpath_result = xpath_query '/persons/participantAssociation'
        data = {}
        internal = []
        external = []
        other = []
        xpath_result.each do |i|
          o = {}
          name = {}
          name['first'] = i.xpath('person/name/firstName').text.strip
          name['last'] = i.xpath('person/name/lastName').text.strip
          o['name'] = name
          o['role'] = i.xpath('personRole/term/localizedString').text.strip

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

      # @return [String]
      def status
        xpath_query_for_single_value '/status/term/localizedString'
      end

      # @return [Hash]
      def temporal
        o = {}
        o['expected'] = {}
        o['actual'] = {}

        xpath_result =  xpath_query '/expectedStartDate'
        o['expected']['start'] = xpath_result.text.strip

        xpath_result =  xpath_query '/expectedEndDate'
        o['expected']['end'] = xpath_result.text.strip

        xpath_result =  xpath_query '/startFinishDate/startDate'
        o['actual']['start'] = xpath_result.text.strip

        xpath_result =  xpath_query '/startFinishDate/endDate'
        o['actual']['end'] = xpath_result.text.strip

        o
      end

      # @return [String]
      def title
        xpath_query_for_single_value '/title/localizedString'
      end

      # @return [String]
      def type
        xpath_query_for_single_value '/typeClassification/term/localizedString'
      end

      # @return [String]
      def url
        xpath_query_for_single_value '/projectURL'
      end      

    end

  end

end