module Puree

  module XMLExtractor

    # Project XML extractor.
    #
    class Project < Puree::XMLExtractor::Resource
      include Puree::XMLExtractor::ExternalOrganisationMixin
      include Puree::XMLExtractor::IdentifierMixin
      include Puree::XMLExtractor::OrganisationMixin
      include Puree::XMLExtractor::PersonMixin
      include Puree::XMLExtractor::TitleMixin
      include Puree::XMLExtractor::TypeMixin

      def initialize(xml)
        super
        setup_model :project
      end

      # @return [String, nil]
      def acronym
        xpath_query_for_single_value '/acronym'
      end

      # @return [String, nil]
      def description
        xpath_query_for_single_value '/descriptions/description'
      end

      # @return [Puree::Model::OrganisationHeader, nil]
      def owner
        xpath_result = xpath_query '/owner'
        Puree::XMLExtractor::Shared.organisation_header xpath_result
      end

      # @return [Array<Puree::Model::EndeavourPerson>]
      def persons_internal
        persons 'internal', '/participants/participant'
      end

      # @return [Array<Puree::Model::EndeavourPerson>]
      def persons_external
        persons 'external', '/participants/participant'
      end

      # @return [Array<Puree::Model::EndeavourPerson>]
      def persons_other
        persons 'other', '/participants/participant'
      end

      # @return [String, nil]
      def status
        xpath_query_for_single_value '/status'
      end

      # Pure deprecated
      # @return [Puree::Model::TemporalRange, nil]
      # def temporal_expected
      #   temporal_range '/expectedStartDate', '/expectedEndDate'
      # end

      # @return [Puree::Model::TemporalRange, nil]
      def temporal
        temporal_range '/period/startDate', '/period/endDate'
      end

      # @return [String, nil]
      def url
        xpath_query_for_single_value '/links/link/url'
      end

      private

      def xpath_root
        '/project'
      end

      def combine_metadata
        super
        @model.acronym = acronym
        @model.description = description
        @model.external_organisations = external_organisations
        @model.identifiers = identifiers
        @model.organisations = organisations
        @model.owner = owner
        @model.persons_internal = persons_internal
        @model.persons_external = persons_external
        @model.persons_other = persons_other
        @model.status = status
        @model.temporal = temporal
        @model.title = title
        @model.type = type
        @model.url = url
        @model
      end      

      # @return [Puree::Model::TemporalRange, nil]
      def temporal_range(start_path, end_path)
        range_start = xpath_query_for_single_value start_path
        range_end = xpath_query_for_single_value end_path
        if range_start || range_end
          range = Puree::Model::TemporalRange.new
          range.start = Time.new range_start if range_start
          range.end = Time.new range_end if range_end
          return range
        end
        nil
      end

    end

  end

end