module Puree

  module XMLExtractor

    # Resource XML extractor.
    #
    class Resource < Puree::XMLExtractor::Base

      def initialize(xml:)
        super
      end

      # content based
      def xpath_query(path)
        # path_from_root = service_xpath path
        path_from_root = File.join xpath_root, path
        @doc.xpath path_from_root
      end

      # Is there any data after get? For a response that provides a count of the results.
      # @return [Boolean]
      def get_data?
        path = service_xpath_count
        xpath_result = @doc.xpath path
        xpath_result.text.strip === '1' ? true : false
      end

      # @return [String, nil]
      def created_by
        xpath_query_for_single_value('/info/createdBy')
      end

      # @return [Time, nil]
      def created_at
        Time.parse xpath_query_for_single_value('/info/createdDate')
      end

      # @return [String, nil]
      def modified_by
        xpath_query_for_single_value('/info/modifiedBy')
      end

      # @return [Time, nil]
      def modified_at
        Time.parse xpath_query_for_single_value('/info/modifiedDate')
      end

      # @return [String, nil]
      def uuid
        xpath_query_for_single_value '/@uuid'
      end

      # Locale (e.g. en-GB)
      # @return [String, nil]
      def locale
        str = xpath_query_for_single_value '/@locale'
        str.tr('_','-') if str
      end

      def model
        combine_metadata
      end

      private

      # All metadata
      # @return [Hash]
      def combine_metadata
        raise 'No model to populate' if !@model
        @model.uuid = uuid
        @model.created_by = created_by
        @model.created_at = created_at
        @model.modified_by = modified_by
        @model.modified_at = modified_at
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