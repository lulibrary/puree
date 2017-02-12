module Puree

  # Extractor
  #
  module Extractor

    # Extractor base
    #
    class Base

      def initialize(xml:)
        @api_map = Puree::Map.new.get
        make_doc xml
      end

      def xpath_query_for_single_value(path)
        xpath_result = xpath_query path
        xpath_result ? xpath_result.text.strip : ''
      end

      def xpath_query_for_multi_value(path)
        xpath_result = xpath_query path
        arr = []
        xpath_result.each { |i| arr << i.text.strip }
        arr.uniq
      end

      private

      def make_doc(xml)
        @doc = Nokogiri::XML xml
        @doc.remove_namespaces!
      end

      def service_response_name
        @api_map[:resource_type][@resource_type][:response]
      end

    end

  end

end