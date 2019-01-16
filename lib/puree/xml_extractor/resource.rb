module Puree

  module XMLExtractor

    # Resource XML extractor.
    #
    class Resource < Puree::XMLExtractor::Base

      def initialize(xml)
        super
      end

      # @return [Puree::Model::Resource subclass]
      def model
        combine_metadata
      end

      # @return [String, nil]
      def created_by
        xpath_query_for_single_value('/info/createdBy')
      end

      # @return [Time, nil]
      def created_at
        xpath_result = xpath_query_for_single_value('/info/createdDate')
        Time.parse xpath_result if xpath_result
      end

      # @return [String, nil]
      def modified_by
        xpath_query_for_single_value('/info/modifiedBy')
      end

      # @return [Time, nil]
      def modified_at
        xpath_result = xpath_query_for_single_value('/info/modifiedDate')
        Time.parse xpath_result if xpath_result
      end

      # @return [String, nil]
      def uuid
        xpath_query_for_single_value '/@uuid'
      end

      # @return [Array<String>]
      def previous_uuids
        xpath_query_for_multi_value '/info/previousUuids/previousUuid'
      end

      private

      def xpath_query(path)
        path_from_root = File.join xpath_root, path
        @doc.xpath path_from_root
      end

      # All metadata
      # @return [Hash]
      def combine_metadata
        raise 'No model to populate' if !@model
        @model.uuid = uuid
        @model.created_by = created_by
        @model.created_at = created_at
        @model.modified_by = modified_by
        @model.modified_at = modified_at
        @model.previous_uuids = previous_uuids
      end

    end

  end

end