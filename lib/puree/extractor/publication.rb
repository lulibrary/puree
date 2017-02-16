module Puree

  module Extractor

    class Publication < Resource

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
        @model.file = @extractor.file
        @model.organisation = @extractor.organisation
        @model.page = @extractor.page
        @model.person = @extractor.person
        @model.status = @extractor.status
        @model.subtitle = @extractor.subtitle
        @model.title = @extractor.title
        @model.type = @extractor.type
        @metadata = @model
      end

    end

  end

end
