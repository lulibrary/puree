module Puree

  module XMLExtractor

    # Page range mixin.
    #
    module PageRangeMixin

      # @return [String, nil]
      def page_range
        xpath_result = xpath_query_for_single_value('/pages')
        xpath_result ? xpath_result : nil
      end

    end

  end
end
