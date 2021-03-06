module Puree

  module XMLExtractor

    # Base XML extractor.
    #
    class Base

      def initialize(xml)
        make_doc xml
      end

      # XPath search for a single value, at a given path.
      #
      # @return [String, nil]
      def xpath_query_for_single_value(path)
        xpath_result = xpath_query(path)
        xpath_result.empty? ? nil : xpath_result.first.text.strip
      end

      # XPath search for multiple values, at a given path.
      #
      # @return [Array<String>]
      def xpath_query_for_multi_value(path)
        xpath_result = xpath_query path
        arr = []
        xpath_result.each { |i| arr << i.text.strip }
        arr.uniq
      end

      private

      def setup_model(resource)
        resource_class = "Puree::Model::#{Puree::Util::String.titleize(resource)}"
        @model = Object.const_get(resource_class).new
      end

      def make_doc(xml)
        @doc = Nokogiri::XML xml
        @doc.remove_namespaces!
      end

    end

  end

end