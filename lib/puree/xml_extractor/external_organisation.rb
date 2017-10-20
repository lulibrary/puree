module Puree

  module XMLExtractor

    # External organisation XML extractor.
    #
    class ExternalOrganisation < Puree::XMLExtractor::Resource

      def initialize(xml:)
        super
        @resource_type = :external_organisation
      end

      # @return [String, nil]
      def name
        xpath_query_for_single_value '/name'
      end

      # @return [String, nil]
      def type
        xpath_query_for_single_value '/typeClassification/uri'
      end

    end

  end

end