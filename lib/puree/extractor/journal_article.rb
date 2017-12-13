module Puree
  module Extractor

    # Journal article extractor.
    #
    class JournalArticle < Puree::Extractor::Publication

      # @option (see Puree::Extractor::Resource#initialize)
      def initialize(config)
        super
      end

      # @param id [String]
      def find(id)
        find_and_extract id: id,
                         api_resource_type: :journal_article,
                         xml_extractor_resource_type: :journal_article
      end

    end

  end
end
