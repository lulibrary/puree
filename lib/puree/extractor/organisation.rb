module Puree

  module Extractor

    class Organisation < Resource

      # @param base_url [String]
      def initialize(base_url:)
        super
        setup :organisation
      end

      private

      def combine_metadata
        super
        @model.address = @extractor.address
        @model.email = @extractor.email
        @model.name = @extractor.name
        @model.organisation = @extractor.organisation
        @model.parent = @extractor.parent
        @model.phone = @extractor.phone
        @model.type = @extractor.type
        @model.url = @extractor.url
        @metadata = @model
      end

    end

  end

end
