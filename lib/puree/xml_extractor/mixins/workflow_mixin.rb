module Puree

  module XMLExtractor

    # Workflow extractor mixin.
    #
    module WorkflowMixin

      # @return [String, nil]
      def workflow
        xpath_query_for_single_value '/workflows/workflow'
      end

    end

  end
end
