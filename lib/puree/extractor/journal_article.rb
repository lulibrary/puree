module Puree
  module Extractor

    # Journal article extractor.
    #
    class JournalArticle < Puree::Extractor::Publication

      # @option (see Puree::Extractor::Resource#initialize)
      def initialize(config)
        set_model_type 'journal_article'
        super
      end

      private

      def combine_metadata
        super

        @model.article_number = @extractor.article_number
        @model.issue = @extractor.issue
        @model.journal = @extractor.journal
        @model.pages = @extractor.pages
        @model.page_range = @extractor.page_range
        @model.peer_reviewed = @extractor.peer_reviewed
        @model.volume = @extractor.volume
        @model
      end

    end

  end
end
