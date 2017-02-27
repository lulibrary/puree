module Puree
  module Model
    class LegalCondition < Puree::Model::Structure

      # @return [String, nil]
      attr_reader :name

      # @return [String, nil]
      attr_reader :description

      # @param [String]
      def name=(v)
        @name = v if v && !v.empty?
      end

      # @param [String]
      def description=(v)
        @description = v if v && !v.empty?
      end

    end
  end
end