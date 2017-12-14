module Puree
  module Model

    # A minimal representation of an organisational unit.
    #
    class OrganisationalUnitHeader < Puree::Model::Structure

      # @return [String, nil]
      attr_reader :uuid

      # @return [String, nil]
      attr_reader :name

      # @return [String, nil]
      attr_reader :type

      # @param v [String]
      def uuid=(v)
        @uuid = v if v && !v.empty?
      end

      # @param v [String]
      def name=(v)
        @name = v if v && !v.empty?
      end

      # @param v [String]
      def type=(v)
        @type = v if v && !v.empty?
      end

    end
  end
end