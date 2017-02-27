module Puree
  module Model
    class OrganisationHeader < Puree::Model::Structure

      # @return [String, nil]
      attr_reader :uuid

      # @return [String, nil]
      attr_reader :name

      # @return [String, nil]
      attr_reader :type

      # @param [String]
      def uuid=(v)
        @uuid = v if v && !v.empty?
      end

      # @param [String]
      def name=(v)
        @name = v if v && !v.empty?
      end

      # @param [String]
      def type=(v)
        @type = v if v && !v.empty?
      end

    end
  end
end