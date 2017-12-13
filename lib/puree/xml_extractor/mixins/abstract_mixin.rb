module Puree

  module XMLExtractor

    # Abstract mixin.
    #
    module AbstractMixin

      # @return [String, nil]
      def description
        xpath_query_for_single_value '/abstract'
      end

    end

  end
end
