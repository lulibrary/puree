module Puree

  module XMLExtractor

    # Abstract mixin.
    #
    module AbstractMixin

      # @return [String, nil]
      def description
        xpath_query_for_multi_value('/abstracts/abstract').first
      end

    end

  end
end
