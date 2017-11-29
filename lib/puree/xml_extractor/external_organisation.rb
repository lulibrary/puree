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
        xpath_query_for_single_value '/type'
      end

      private

      def xpath_root
        '/externalOrganisation'
      end

    end

  end

end