module Puree

  module XMLExtractor

    # Title mixin.
    #
    module TitleMixin

      # @return [String, nil]
      def title
        xpath_query_for_single_value '/title/text'
      end

    end

  end
end
