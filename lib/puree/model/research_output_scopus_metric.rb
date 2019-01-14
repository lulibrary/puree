module Puree
  module Model

    # A Scopus metric.
    #
    class ResearchOutputScopusMetric < Puree::Model::Structure

      # @return [Integer, nil]
      attr_accessor :value

      # @return [Integer, nil]
      attr_accessor :year

    end
  end
end