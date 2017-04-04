module Puree
  module Model

    # A journal article.
    #
    class JournalArticle < Puree::Model::Publication

      # @return [Fixnum, nil]
      attr_accessor :article_number

      # @return [String, nil]
      attr_accessor :bibliographical_note

      # @return [Array<String>, nil]
      attr_accessor :dois

      # @return [Puree::Model::JournalHeader, nil]
      attr_accessor :journal

      # @return [Fixnum, nil]
      attr_accessor :issue

      # @return [Fixnum, nil]
      attr_accessor :pages

      # @return [String, nil]
      attr_accessor :page_range

      # @return [Boolean, nil]
      attr_accessor :peer_reviewed

      # @return [Fixnum, nil]
      attr_accessor :volume

    end
  end
end