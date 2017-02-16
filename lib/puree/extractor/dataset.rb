module Puree

  module Extractor

    class Dataset < Resource

      # @param base_url [String]
      def initialize(base_url:)
        super
        setup :dataset
      end

      private

      def combine_metadata
        super
        @model.access = @extractor.access
        @model.associated = @extractor.associated
        @model.available = @extractor.available
        @model.description = @extractor.description
        @model.doi = @extractor.doi
        @model.file = @extractor.file
        @model.keyword = @extractor.keyword
        @model.link = @extractor.link
        @model.organisation = @extractor.organisation
        @model.owner = @extractor.owner
        @model.person = @extractor.person
        @model.project = @extractor.project
        @model.production = @extractor.production
        @model.publication = @extractor.publication
        @model.publisher = @extractor.publisher
        @model.spatial = @extractor.spatial
        @model.spatial_point = @extractor.spatial_point
        @model.temporal = @extractor.temporal
        @model.title = @extractor.title
        @metadata = @model
      end

    end

  end

end