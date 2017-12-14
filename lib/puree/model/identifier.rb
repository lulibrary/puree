module Puree
  module Model

    # An identifier.
    #
    class Identifier < Puree::Model::Structure

      # @return [String, nil]
      attr_reader :id

      # @return [String, nil]
      attr_reader :type

      # @param v [String]
      def id=(v)
        @id = v if v && !v.empty?
      end

      # @param v [String]
      def type=(v)
        @type = v if v && !v.empty?
      end

    end
  end
end