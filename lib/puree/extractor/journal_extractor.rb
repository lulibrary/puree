module Puree

  # Extractor
  #
  module Extractor

    # Journal extractor
    #
    class Journal < Puree::Extractor::Resource

      def initialize(xml:)
        @resource_type = :journal
        super
      end

      def issn
        xpath_query_for_single_value '/issns/issn/string'
      end

      def publisher
        xpath_query_for_single_value '/publisher/name'
      end

      def title
        xpath_query_for_single_value '/titles/title/string'
      end

    end

  end

end