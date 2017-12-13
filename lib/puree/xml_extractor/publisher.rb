module Puree

  module XMLExtractor

    # Publisher XML extractor.
    #
    class Publisher < Puree::XMLExtractor::Resource

      def initialize(xml)
        super
        setup_model :publisher
      end

      # @return [String, nil]
      def name
        xpath_query_for_single_value '/name'
      end

      # Adds no value as value is Publisher
      # def type
      #   xpath_query_for_single_value '/typeClassification/term/localizedString'
      # end

      private

      def xpath_root
        '/publisher'
      end

      def combine_metadata
        super
        @model.name = name
        @model
      end

    end

  end

end