module Puree

  module XMLExtractor

    class Project < Puree::XMLExtractor::Resource

      def initialize(xml:)
        super
        @resource_type = :project
      end

      # @return [String, nil]
      def acronym
        xpath_query_for_single_value '/acronym'
      end

      # @return [String, nil]
      def description
        xpath_query_for_single_value '/description/localizedString'
      end

      # @return [Array<Puree::OrganisationHeader>]
      def organisations
        xpath_result = xpath_query '/organisations/association/organisation'
        Puree::XMLExtractor::Shared.multi_header xpath_result
      end

      # @return [Puree::OrganisationHeader]
      def owner
        xpath_result =  xpath_query '/owner'
        Puree::XMLExtractor::Shared.header xpath_result
      end

      # Internal persons
      # @return [Array<Puree::EndeavourPerson>]
      def persons_internal
        persons 'internal'
      end

      # External persons
      # @return [Array<Puree::EndeavourPerson>]
      def persons_external
        persons 'external'
      end

      # Other persons
      # @return [Array<Puree::EndeavourPerson>]
      def persons_other
        persons 'other'
      end

      # @return [String, nil]
      def status
        xpath_query_for_single_value '/status/term/localizedString'
      end

      # @return [Puree::TemporalRange]
      def temporal_expected
        expected_start = xpath_query('/expectedStartDate').text.strip
        expected_end = xpath_query('/expectedEndDate').text.strip
        range = Puree::TemporalRange.new
        range.start = expected_start
        range.end = expected_end
        range
      end

      # @return [Puree::TemporalRange]
      def temporal_actual
        actual_start = xpath_query('/startFinishDate/startDate').text.strip
        actual_end = xpath_query('/startFinishDate/endDate').text.strip
        range = Puree::TemporalRange.new
        range.start = actual_start
        range.end = actual_end
        range
      end

      # @return [String, nil]
      def title
        xpath_query_for_single_value '/title/localizedString'
      end

      # @return [String, nil]
      def type
        xpath_query_for_single_value '/typeClassification/term/localizedString'
      end

      # @return [String, nil]
      def url
        xpath_query_for_single_value '/projectURL'
      end

      private

      # Internal persons
      # @return [Array<Endeavour::Person>]
      def persons(type)
        xpath_result = xpath_query '/persons/participantAssociation'
        arr = []
        xpath_result.each do |i|
          person = Puree::EndeavourPerson.new

          name = Puree::PersonName.new
          name.first = i.xpath('person/name/firstName').text.strip
          name.last = i.xpath('person/name/lastName').text.strip
          person.name = name

          role = i.xpath('personRole/term/localizedString').text.strip
          person.role = role

          if type === 'internal'
            uuid = i.at_xpath('person/@uuid')
          elsif type === 'external'
            uuid = i.at_xpath('externalPerson/@uuid')
          # elsif type === 'other'
          #   uuid = nil
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