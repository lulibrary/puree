module Puree

  module XMLExtractor

    # Pages extractor mixin.
    #
    module PagesMixin

      # @return [Integer, nil]
      def pages
        xpath_result = xpath_query_for_single_value('/numberOfPages')
        xpath_result ? xpath_result.to_i : nil
      end

    end

  end
end
