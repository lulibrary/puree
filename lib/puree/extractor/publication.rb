module Puree

  module Extractor

    # Publication extractor.
    #
    class Publication < Puree::Extractor::Resource

      # @option (see Puree::Extractor::Resource#initialize)
      def initialize(config)
        super
        setup :publication
      end

      private

      def combine_metadata
        super

        @model.associated = @extractor.associated
        @model.bibliographical_note = @extractor.bibliographical_note
        @model.category = @extractor.category
        @model.description = @extractor.description
        @model.dois = @extractor.dois
        @model.external_organisations = @extractor.external_organisations
        @model.files = @extractor.files
        @model.keywords = @extractor.keywords
        @model.language = @extractor.language
        @model.links = @extractor.links
        @model.organisations = @extractor.organisations
        @model.owner = @extractor.owner
        @model.persons_internal = @extractor.persons_internal
        @model.persons_external = @extractor.persons_external
        @model.persons_other = @extractor.persons_other
        # @model.publication_place = @extractor.publication_place
        @model.publisher = @extractor.publisher
        @model.statuses = @extractor.statuses
        @model.subtitle = @extractor.subtitle
        @model.title = @extractor.title
        @model.translated_subtitle = @extractor.translated_subtitle
        @model.translated_title = @extractor.translated_title
        @model.type = @extractor.type
        @model.workflow_state = @extractor.workflow_state
        @model
      end

    end

  end

end
