module Puree

  module XMLExtractor

    # Keyword mixin.
    #
    module KeywordMixin

      # @return [Array<String>]
      def keywords
        xpath_result =  xpath_query '/keywordGroups/keywordGroup[@logicalName="User-Defined Keywords"]/keywords/keyword'
        data_arr = xpath_result.map { |i| i.text.strip }
        data_arr.uniq
      end

    end

  end
end
