module Puree

  module XMLExtractor

    # External organisation XML extractor.
    #
    class ExternalOrganisation < Puree::XMLExtractor::Resource
      include Puree::XMLExtractor::TypeMixin

      def initialize(xml)
        super
        setup_model :external_organisation
      end

      # @return [String, nil]
      def name
        xpath_query_for_single_value '/name/text'
      end

      private

      def xpath_root
        '/externalOrganisation'
      end

      def combine_metadata
        super
        @model.name = name
        @model.type = type
        @model
      end

    end

  end

end