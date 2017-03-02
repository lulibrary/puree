module Puree
  module Model

    # A legal condition
    #
    class LegalCondition < Puree::Model::Structure

      # @return [String, nil]
      attr_reader :name

      # @return [String, nil]
      attr_reader :description

      # @param v [String]
      def name=(v)
        @name = v if v && !v.empty?
      end

      # @param v [String]
      def description=(v)
        @description = v if v && !v.empty?
      end

    end
  end
end