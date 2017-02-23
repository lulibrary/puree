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

      # @return [Array<Puree::Model::OrganisationHeader>]
      def organisations
        xpath_result = xpath_query '/organisations/association/organisation'
        Puree::XMLExtractor::Shared.multi_header xpath_result
      end

      # @return [Puree::Model::OrganisationHeader]
      def owner
        xpath_result = xpath_query '/owner'
        Puree::XMLExtractor::Shared.header xpath_result
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

      # @return [String]
      def status
        xpath_query_for_single_value '/status/term/localizedString'
      end

      # @return [Puree::Model::TemporalRange]
      def temporal_expected
        temporal_range '/expectedStartDate', '/expectedEndDate'
      end

      # @return [Puree::Model::TemporalRange]
      def temporal_actual
        temporal_range '/startFinishDate/startDate', '/startFinishDate/endDate'
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

      private

      # @return [Array<Endeavour::Person>]
      def persons(type)
        xpath_result = xpath_query '/persons/participantAssociation'
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
            name.first = i.xpath('person/name/firstName').text.strip
            name.last = i.xpath('person/name/lastName').text.strip
            person.name = name
            role = i.xpath('personRole/term/localizedString').text.strip
            person.role = role
            arr << person
          end
        end
        arr
      end

      # @return [Puree::Model::TemporalRange]
      def temporal_range(start_path, end_path)
        range = Puree::Model::TemporalRange.new
        range.start = xpath_query(start_path).text.strip
        range.end = xpath_query(end_path).text.strip
        range
      end

    end

  end

end