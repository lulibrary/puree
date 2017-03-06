module Puree

  module Extractor

    # Person extractor.
    #
    class Person < Puree::Extractor::Resource

      # @option (see Puree::Extractor::Resource#initialize)
      def initialize(config)
        super
        setup :person
      end

      private

      def combine_metadata
        super
        @model.affiliations = @extractor.affiliations
        @model.email_addresses = @extractor.email_addresses
        @model.image_urls = @extractor.image_urls
        @model.keywords = @extractor.keywords
        @model.name = @extractor.name
        @model.orcid = @extractor.orcid
        @model
      end

    end

  end

end
