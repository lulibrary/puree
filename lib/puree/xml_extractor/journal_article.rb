module Puree
  module XMLExtractor

    # Journal article XML extractor.
    #
    class JournalArticle < Puree::XMLExtractor::Publication
      include Puree::XMLExtractor::PagesMixin
      include Puree::XMLExtractor::PageRangeMixin
      include Puree::XMLExtractor::PeerReviewedMixin

      def initialize(xml:)
        super
        setup_model :journal_article
      end

      # @return [Fixnum, nil]
      def issue
        xpath_result = xpath_query_for_single_value('/journalNumber')
        xpath_result ? xpath_result.to_i : nil
      end

      # @return [Puree::Model::JournalHeader, nil]
      def journal
        xpath_result = xpath_query '/journalAssociation'
        if !xpath_result.empty?
          header = Puree::Model::JournalHeader.new
          header.title = xpath_result.xpath('title').text.strip
          journal = xpath_result.xpath('journal')
          header.type = journal.xpath('type').text.strip
          header.uuid = journal.attr('uuid').text.strip
          header
        end
      end

      # @return [Fixnum, nil]
      def volume
        xpath_result = xpath_query_for_single_value('/volume')
        xpath_result ? xpath_result.to_i : nil
      end


      private

      def xpath_root
        '/contributionToJournal'
      end

      def combine_metadata
        super
        @model.issue = issue
        @model.journal = journal
        @model.pages = pages
        @model.page_range = page_range
        @model.peer_reviewed = peer_reviewed
        @model.volume = volume
        @model
      end      

    end
  end
end
