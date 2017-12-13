module Puree

  module XMLExtractor

    # Journal XML extractor.
    #
    class Journal < Puree::XMLExtractor::Resource

      def initialize(xml)
        super
        setup_model :journal
      end

      # @return [String, nil]
      def issn
        xpath_query_for_single_value '/issns/issn'
      end

      # @return [String, nil]
      def publisher
        xpath_query_for_single_value '/publisher/name'
      end

      # @return [String, nil]
      def title
        xpath_query_for_single_value '/titles/title'
      end

      private

      def combine_metadata
        super
        @model.issn = issn
        @model.publisher = publisher
        @model.title = title
        @model
      end

      def xpath_root
        '/journal'
      end

    end

  end

end