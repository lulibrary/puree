module Puree

  module XMLExtractor

    # Journal XML extractor.
    #
    class Journal < Puree::XMLExtractor::Resource
      include Puree::XMLExtractor::PublisherMixin

      def initialize(xml)
        super
        setup_model :journal
      end

      # @return [String, nil]
      def issn
        xpath_query_for_single_value '/issns/issn'
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