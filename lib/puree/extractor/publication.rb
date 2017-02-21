module Puree

  module Extractor

    class Publication < Puree::Extractor::Resource

      # @param url [String]
      def initialize(url:)
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
        @model.organisations = @extractor.organisations
        @model.page = @extractor.page
        @model.persons_internal = @extractor.persons_internal
        @model.persons_external = @extractor.persons_external
        @model.persons_other = @extractor.persons_other
        @model.statuses = @extractor.statuses
        @model.subtitle = @extractor.subtitle
        @model.title = @extractor.title
        @model.type = @extractor.type
        @metadata = @model
      end

    end

  end

end
