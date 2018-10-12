module Puree
  module Extractor

    # Journal article extractor.
    #
    class JournalArticle < Puree::Extractor::Resource

      # @param id [String]
      # @return [Puree::Model::JournalArticle, nil]
      def find(id)
        super id: id,
              api_resource_type: :research_output,
              xml_extractor_resource_type: :journal_article
      end

      # Random record.
      #
      # @param params [Hash] Combined GET and POST parameters for all records
      # @return [Puree::Model::JournalArticle, nil]
      def random(params = {})
        record_count :journal_article, params
      end

    end

  end
end
