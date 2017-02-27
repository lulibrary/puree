module Puree
  module Model
    class RelatedContentHeader < Puree::Model::Structure

      # @return [String, nil]
      attr_reader :uuid

      # @return [String, nil]
      attr_reader :title

      # @return [String, nil]
      attr_reader :type

      # @param [String]
      def uuid=(v)
        @uuid = v if v && !v.empty?
      end

      # @param [String]
      def title=(v)
        @title = v if v && !v.empty?
      end

      # @param [String]
      def type=(v)
        @type = v if v && !v.empty?
      end

    end
  end
end