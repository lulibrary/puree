module Puree

  module XMLExtractor

    # Workflow extractor mixin.
    #
    module WorkflowMixin

      # @return [String, nil]
      def workflow
        xpath_query_for_multi_value('/workflows/workflow').first
      end

    end

  end
end
