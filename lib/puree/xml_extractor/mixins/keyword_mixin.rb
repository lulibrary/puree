module Puree

  module XMLExtractor

    # Keyword mixin.
    #
    module KeywordMixin

      private

      # @return [Array<String>]
      def keyword_group(logical_name)
        xpath_result = xpath_query "/keywordGroups/keywordGroup[@logicalName='#{logical_name}']/keywordContainers/keywordContainer/freeKeywords/freeKeyword/freeKeywords/freeKeyword"
        data_arr = xpath_result.map { |i| i.text.strip }
        data_arr.uniq
      end

    end

  end
end
