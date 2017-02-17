module Puree

  module Extractor

    class Person < Puree::Extractor::Resource

      # @param url [String]
      def initialize(url:)
        super
        setup :person
      end

      private

      def combine_metadata
        super
        @model.affiliation = @extractor.affiliation
        @model.email = @extractor.email
        @model.image = @extractor.image
        @model.keyword = @extractor.keyword
        @model.name = @extractor.name
        @model.orcid = @extractor.orcid
        @metadata = @model
      end

    end

  end

end
