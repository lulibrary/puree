module Puree

  module XMLExtractor

    # Title mixin.
    #
    module TitleMixin

      # @return [String, nil]
      def title
        xpath_query_for_multi_value('/titles/title').first
      end

    end

  end
end
