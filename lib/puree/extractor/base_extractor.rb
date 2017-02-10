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

      # content based
      def xpath_query(path)
        path_from_root = service_xpath path
        @doc.xpath path_from_root
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

      # Is there any data after get? For a response that provides a count of the results.
      # @return [Boolean]
      def get_data?
        path = service_xpath_count
        xpath_result = @doc.xpath path
        xpath_result.text.strip === '1' ? true : false
      end

      def created
        xpath_query_for_single_value '/created'
      end

      def modified
        xpath_query_for_single_value '/modified'
      end

      def uuid
        xpath_query_for_single_value '/@uuid'
      end

      def locale
        str = xpath_query_for_single_value '/@locale'
        str.tr('_','-')
      end

      private

      def make_doc(xml)
        @doc = Nokogiri::XML xml
        @doc.remove_namespaces!
      end

      def service_response_name
        @api_map[:resource_type][@resource_type][:response]
      end

      def service_xpath_base
        service_response_name + '/result/content'
      end

      def service_xpath_count
        service_response_name + '/count'
      end

      def service_xpath(str_to_find)
        service_xpath_base + str_to_find
      end

    end

  end

end