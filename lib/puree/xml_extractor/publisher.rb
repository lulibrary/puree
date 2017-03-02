module Puree

  module XMLExtractor

    # Publisher XML extractor
    #
    class Publisher < Puree::XMLExtractor::Resource

      def initialize(xml:)
        super
        @resource_type = :publisher
      end

      # @return [String, nil]
      def name
        xpath_query_for_single_value '/name'
      end

      # Adds no value as value is Publisher
      # def type
      #   xpath_query_for_single_value '/typeClassification/term/localizedString'
      # end

    end

  end

end