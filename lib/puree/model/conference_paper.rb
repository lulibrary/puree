module Puree
  module Model

    # A conference paper.
    #
    class ConferencePaper < Puree::Model::Publication

      # @return [String, nil]
      attr_accessor :bibliographical_note

      # # @return [Fixnum, nil]
      attr_accessor :pages

      # @return [String, nil]
      attr_accessor :page_range

      # @return [Boolean, nil]
      attr_accessor :peer_reviewed

    end
  end
end