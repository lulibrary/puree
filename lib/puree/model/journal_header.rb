module Puree
  module Model

    # A minimal representation of a journal.
    #
    class JournalHeader < Puree::Model::Structure

      # @return [String, nil]
      attr_reader :uuid

      # @return [String, nil]
      attr_reader :title

      # @return [String, nil]
      attr_reader :type

      # @param v [String]
      def uuid=(v)
        @uuid = v if v && !v.empty?
      end

      # @param v [String]
      def title=(v)
        @title = v if v && !v.empty?
      end

      # @param v [String]
      def type=(v)
        @type = v if v && !v.empty?
      end

    end
  end
end