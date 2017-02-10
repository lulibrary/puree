module Puree

  # Extractor
  #
  module Extractor

    # Project extractor
    #
    class Project < Puree::Extractor::Base

      def initialize(xml:)
        @resource_type = :project
        super
      end

      def acronym
        xpath_query_for_single_value '/acronym'
      end

      def description
        xpath_query_for_single_value '/description/localizedString'
      end

      def organisation
        xpath_result = xpath_query '/organisations/association/organisation'
        Puree::Extractor::Shared.multi_header xpath_result
      end

      def owner
        xpath_result =  xpath_query '/owner'
        Puree::Extractor::Shared.header xpath_result
      end

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

      def status
        xpath_query_for_single_value '/status/term/localizedString'
      end

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

      def title
        xpath_query_for_single_value '/title/localizedString'
      end

      def type
        xpath_query_for_single_value '/typeClassification/term/localizedString'
      end

      def url
        xpath_query_for_single_value '/projectURL'
      end      

    end

  end

end