module Puree

  module Extractor

    # Organisation extractor
    #
    class Organisation < Puree::Extractor::Resource

      # @param url [String]
      def initialize(url:)
        super
        setup :organisation
      end

      private

      def combine_metadata
        super
        @model.address = @extractor.address
        @model.email_addresses = @extractor.email_addresses
        @model.name = @extractor.name
        @model.organisations = @extractor.organisations
        @model.parent = @extractor.parent
        @model.phone_numbers = @extractor.phone_numbers
        @model.type = @extractor.type
        @model.urls = @extractor.urls
        @model
      end

    end

  end

end
