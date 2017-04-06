module Puree
  module Model

    # A base paper.
    #
    class PaperBase < Puree::Model::Publication

      # @return [Fixnum, nil]
      attr_accessor :pages

      # @return [String, nil]
      attr_accessor :page_range

      # @return [Boolean, nil]
      attr_accessor :peer_reviewed

    end
  end
end