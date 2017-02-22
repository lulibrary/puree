module Puree

  module XMLExtractor

    class Journal < Puree::XMLExtractor::Resource

      def initialize(xml:)
        super
        @resource_type = :journal
      end

      # @return [String]
      def issn
        xpath_query_for_single_value '/issns/issn/string'
      end

      ## @return [String]
      def publisher
        xpath_query_for_single_value '/publisher/name'
      end

      # @return [String]
      def title
        xpath_query_for_single_value '/titles/title/string'
      end

    end

  end

end