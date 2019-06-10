module Puree

  module XMLExtractor

    # Type mixin.
    #
    module TypeMixin

      # @return [String, nil]
      def type
        xpath_query_for_multi_value('/types/type').first
      end

    end

  end
end
