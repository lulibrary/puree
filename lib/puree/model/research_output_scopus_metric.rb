module Puree
  module Model

    # A Scopus metric.
    #
    class ResearchOutputScopusMetric < Puree::Model::Structure

      # @return [Integer, nil]
      attr_reader :value

      # @return [Integer, nil]
      attr_reader :year

      # @param v [Integer]
      def value=(v)
        @value = v if v && !v.empty?
      end

      # @param v [Integer]
      def year=(v)
        @year = v if v && !v.empty?
      end

    end
  end
end