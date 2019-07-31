module Puree

  module XMLExtractor

    # Description mixin.
    #
    module DescriptionMixin

      # @return [String, nil]
      def description
        xpath_query_for_single_value '/descriptions/description'
      end

    end

  end
end
