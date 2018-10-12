module Puree
  module Model

    # A journal article.
    #
    class JournalArticle < Puree::Model::ResearchOutput

      # @return [Puree::Model::JournalHeader, nil]
      attr_accessor :journal

      # @return [Integer, nil]
      attr_accessor :issue

      # @return [Integer, nil]
      attr_accessor :pages

      # @return [String, nil]
      attr_accessor :page_range

      # @return [Boolean, nil]
      attr_accessor :peer_reviewed

      # @return [Integer, nil]
      attr_accessor :volume

    end
  end
end