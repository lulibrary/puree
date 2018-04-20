module Puree
  module Extractor

    # Journal article extractor.
    #
    class JournalArticle < Puree::Extractor::Resource

      # @param id [String]
      # @return [Puree::Model::JournalArticle, nil]
      def find(id)
        find_and_extract id: id,
                         api_resource_type: :research_output,
                         xml_extractor_resource_type: :journal_article
      end

      # Random resource.
      #
      # @return [Puree::Model::JournalArticle, nil]
      def random
        super :journal_article
      end

    end

  end
end
