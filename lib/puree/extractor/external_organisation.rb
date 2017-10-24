module Puree

  module Extractor

    # External organisation extractor.
    #
    class ExternalOrganisation < Puree::Extractor::Resource

      # @option (see Puree::Extractor::Resource#initialize)
      def initialize(config)
        super
        setup :external_organisation
      end

      private

      def combine_metadata
        super
        @model.name = @extractor.name
        @model.type = @extractor.type
        @model
      end

    end

  end

end
