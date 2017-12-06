module Puree

  module XMLExtractor

    # Type mixin.
    #
    module TypeMixin

      # @return [String, nil]
      def type
        xpath_query_for_single_value '/type'
      end

    end

  end
end
