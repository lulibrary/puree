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
        @model.category = @extractor.category
        @model.description = @extractor.description
        @model.doi = @extractor.doi
        @model.event = @extractor.event
        @model.files = @extractor.files
        @model.keywords = @extractor.keywords
        @model.organisations = @extractor.organisations
        @model.pages = @extractor.pages
        @model.persons_internal = @extractor.persons_internal
        @model.persons_external = @extractor.persons_external
        @model.persons_other = @extractor.persons_other
        @model.publisher = @extractor.publisher
        @model.statuses = @extractor.statuses
        @model.subtitle = @extractor.subtitle
        @model.title = @extractor.title
        @model.type = @extractor.type
        @model
      end

    end

  end

end
