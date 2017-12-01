module Puree

  module Extractor

    # Project extractor.
    #
    class Project < Puree::Extractor::Resource

      # @option (see Puree::Extractor::Resource#initialize)
      def initialize(config)
        super
        @latest_api = false # current API does not return person roles
        setup :project
      end

      private

      def combine_metadata
        super
        @model.acronym = @extractor.acronym
        # @model.associated = @extractor.associated # not present in stable API
        @model.description = @extractor.description
        @model.external_organisations = @extractor.external_organisations
        @model.organisations = @extractor.organisations
        @model.owner = @extractor.owner
        @model.persons_internal = @extractor.persons_internal
        @model.persons_external = @extractor.persons_external
        @model.persons_other = @extractor.persons_other
        @model.status = @extractor.status
        # @model.temporal_actual = @extractor.temporal_actual
        @model.temporal = @extractor.temporal
        @model.title = @extractor.title
        @model.type = @extractor.type
        @model.url = @extractor.url
        @model
      end

    end

  end

end
