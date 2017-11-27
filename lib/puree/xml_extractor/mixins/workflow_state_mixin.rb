module Puree

  module XMLExtractor

    # Workflow state extractor mixin.
    #
    module WorkflowStateMixin

      # Workflow state
      # @return [String, nil]
      def workflow_state
        xpath_query_for_single_value '/workflow'
      end

    end

  end
end
