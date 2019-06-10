module Puree

  module XMLExtractor

    # Description mixin.
    #
    module DescriptionMixin

      # @return [String, nil]
      def description
        xpath_query_for_multi_value('/descriptions/description').first
      end

    end

  end
end
