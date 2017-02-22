module Puree

  module XMLExtractor

    class Resource < Puree::XMLExtractor::Base

      def initialize(xml:)
        super
      end

      # content based
      def xpath_query(path)
        path_from_root = service_xpath path
        @doc.xpath path_from_root
      end

      # Is there any data after get? For a response that provides a count of the results.
      # @return [Boolean]
      def get_data?
        path = service_xpath_count
        xpath_result = @doc.xpath path
        xpath_result.text.strip === '1' ? true : false
      end

      # Created (UTC datetime)
      # @return [Time]
      def created
        Time.parse xpath_query_for_single_value('/created')
      end

      # Modified (UTC datetime)
      # @return [Time]
      def modified
        Time.parse xpath_query_for_single_value('/modified')
      end

      def uuid
        xpath_query_for_single_value '/@uuid'
      end

      # Locale (e.g. en-GB)
      # @return [String]
      def locale
        str = xpath_query_for_single_value '/@locale'
        str.tr('_','-') if str
      end

      private

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