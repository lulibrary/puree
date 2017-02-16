module Puree

  module XMLExtractor

    class Publisher < Puree::XMLExtractor::Resource

      # @param url [String]
      def initialize(xml:)
        super
        @resource_type = :publisher
      end

      # @return [String]
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