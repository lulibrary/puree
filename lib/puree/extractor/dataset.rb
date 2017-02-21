module Puree

  module Extractor

    class Dataset < Puree::Extractor::Resource

      # @param url [String]
      def initialize(url:)
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
        @model.files = @extractor.files
        @model.keywords = @extractor.keywords
        @model.links = @extractor.links
        @model.organisations = @extractor.organisations
        @model.owner = @extractor.owner
        @model.persons_internal = @extractor.persons_internal
        @model.persons_external = @extractor.persons_external
        @model.persons_other = @extractor.persons_other
        @model.projects = @extractor.projects
        @model.production = @extractor.production
        @model.publications = @extractor.publications
        @model.publisher = @extractor.publisher
        @model.spatial_places = @extractor.spatial_places
        @model.spatial_point = @extractor.spatial_point
        @model.temporal = @extractor.temporal
        @model.title = @extractor.title
        @metadata = @model
      end

    end

  end

end