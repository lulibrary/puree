module Puree

  # Extractor
  #
  module Extractor

    # Publisher extractor
    #
    class Publisher < Puree::Extractor::Resource

      def initialize(xml:)
        @resource_type = :publisher
        super
      end

      def name
        xpath_query_for_single_value '/name'
      end

    end

  end

end