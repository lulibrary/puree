module Puree

  module XMLExtractor

    # Abstract mixin.
    #
    module AbstractMixin

      # @return [String, nil]
      def description
        xpath_query_for_single_value '/abstracts/abstract'
      end

    end

  end
end
