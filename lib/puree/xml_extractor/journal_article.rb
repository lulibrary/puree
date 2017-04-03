module Puree
  module XMLExtractor

    # Journal article XML extractor.
    #
    class JournalArticle < Puree::XMLExtractor::Publication
      include Puree::XMLExtractor::BibliographicalNoteMixin
      include Puree::XMLExtractor::PagesMixin
      include Puree::XMLExtractor::PageRangeMixin
      include Puree::XMLExtractor::PeerReviewedMixin

      def initialize(xml:)
        super
      end

      # @return [Fixnum, nil]
      def article_number
        xpath_query_for_single_value('/articleNumber')
      end

      # @return [Fixnum, nil]
      def issue
        xpath_result = xpath_query_for_single_value('/journalNumber')
        xpath_result ? xpath_result.to_i : nil
      end

      # @return [Puree::Model::JournalHeader, nil]
      def journal
        xpath_result = xpath_query '/journal'
        if !xpath_result.empty?
          header = Puree::Model::JournalHeader.new
          header.title = xpath_result.xpath('title').text.strip
          journal = xpath_result.xpath('journal')
          header.type = journal.xpath('typeClassification/term/localizedString').text.strip
          header.uuid = journal.attr('uuid').text.strip
          return header
        end
        nil
      end

      # @return [Fixnum, nil]
      def volume
        xpath_result = xpath_query_for_single_value('/volume')
        xpath_result ? xpath_result.to_i : nil
      end

    end
  end
end
