module Puree
  module Model

    # A Scopus metric.
    #
    class ScopusMetric < Puree::Model::Structure

      # @return [Fixnum, nil]
      attr_reader :value

      # @return [Fixnum, nil]
      attr_reader :year

      # @param v [Fixnum]
      def value=(v)
        @value = v if v && !v.empty?
      end

      # @param v [Fixnum]
      def year=(v)
        @year = v if v && !v.empty?
      end

    end
  end
end