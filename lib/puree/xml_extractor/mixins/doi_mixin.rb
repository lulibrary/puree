module Puree

  module XMLExtractor

    # DOI extractor mixin.
    #
    module DoiMixin

      # @return [String, nil]
      def doi
        xpath_query_for_single_value '//doi'
      end

    end

  end
end
