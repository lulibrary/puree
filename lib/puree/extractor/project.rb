module Puree

  module Extractor

    class Project < Resource

      # @param url [String]
      def initialize(url:)
        super
        @latest_api = false # stable API does not return person roles
        setup :project
      end

      private

      def combine_metadata
        super
        @model.acronym = @extractor.acronym
        @model.description = @extractor.description
        @model.organisation = @extractor.organisation
        @model.owner = @extractor.owner
        @model.person = @extractor.person
        @model.status = @extractor.status
        @model.temporal = @extractor.temporal
        @model.title = @extractor.title
        @model.type = @extractor.type
        @model.url = @extractor.url
        @metadata = @model
      end

    end

  end

end
