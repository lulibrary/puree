module Puree
  module Model

    # A minimal representation of an ExternalOrganisation.
    #
    class ExternalOrganisationHeader < Puree::Model::Structure

      # @return [String, nil]
      attr_reader :uuid

      # @return [String, nil]
      attr_reader :name

      # @param v [String]
      def uuid=(v)
        @uuid = v if v && !v.empty?
      end

      # @param v [String]
      def name=(v)
        @name = v if v && !v.empty?
      end

    end
  end
end