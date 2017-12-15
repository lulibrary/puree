module Puree

  module XMLExtractor

    # Resource XML extractor.
    #
    class Resource < Puree::XMLExtractor::Base

      def initialize(xml)
        super
      end

      def xpath_query(path)
        path_from_root = File.join xpath_root, path
        @doc.xpath path_from_root
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

    end

  end

end